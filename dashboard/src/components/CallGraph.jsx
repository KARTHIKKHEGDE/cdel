import { useMemo } from 'react'
import {
    ReactFlow,
    Background,
    Controls,
    MarkerType,
    useNodesState,
    useEdgesState,
} from '@xyflow/react'
import useReportStore from '../store/useReportStore'

export default function CallGraph() {
    const report = useReportStore(s => s.report)
    const displayName = useReportStore(s => s.displayName)
    const cg = report.call_graph || { nodes: [], edges: [] }

    const { rfNodes, rfEdges } = useMemo(() => {
        const depth = {}
        const adj = {}
        cg.nodes.forEach(n => { adj[n] = []; depth[n] = 999 })
        cg.edges.forEach(e => adj[e.caller]?.push(e.callee))

        const roots = cg.nodes.filter(n => !cg.edges.some(e => e.callee === n))
        roots.forEach(r => { depth[r] = 0 })
        const queue = [...roots]
        while (queue.length) {
            const cur = queue.shift()
                ; (adj[cur] || []).forEach(next => {
                    if (depth[next] === 999) {
                        depth[next] = depth[cur] + 1
                        queue.push(next)
                    }
                })
        }

        const groups = {}
        cg.nodes.forEach(n => {
            const d = depth[n] === 999 ? 0 : depth[n]
            if (!groups[d]) groups[d] = []
            groups[d].push(n)
        })

        const NODE_W = 180
        const NODE_H = 40
        const H_GAP = 40
        const V_GAP = 80
        const pos = {}
        Object.entries(groups).forEach(([d, ids]) => {
            const totalW = ids.length * NODE_W + (ids.length - 1) * H_GAP
            ids.forEach((id, i) => {
                pos[id] = {
                    x: -totalW / 2 + i * (NODE_W + H_GAP),
                    y: Number(d) * (NODE_H + V_GAP),
                }
            })
        })

        const rfNodes = cg.nodes.map(n => {
            const label = displayName(n)
            const isDemangled = label !== n
            return {
                id: n,
                position: pos[n] || { x: 0, y: 0 },
                data: {
                    label: (
                        <div title={n}>
                            <div className="truncate" style={{ maxWidth: NODE_W - 24 }}>{label}</div>
                            {isDemangled && (
                                <div className="text-[9px] opacity-50 truncate" style={{ maxWidth: NODE_W - 24 }}>{n}</div>
                            )}
                        </div>
                    ),
                },
                style: {
                    background: depth[n] === 0 ? '#1f6feb' : '#161b22',
                    border: `1px solid ${depth[n] === 0 ? '#58a6ff' : '#30363d'}`,
                    borderRadius: 8,
                    color: '#e6edf3',
                    fontSize: 11,
                    fontFamily: 'JetBrains Mono',
                    padding: '8px 12px',
                    width: NODE_W,
                    textAlign: 'center',
                },
            }
        })

        const rfEdges = cg.edges.map((e, i) => ({
            id: `e${i}`,
            source: e.caller,
            target: e.callee,
            style: { stroke: '#58a6ff', strokeWidth: 1.5 },
            markerEnd: { type: MarkerType.ArrowClosed, color: '#58a6ff' },
        }))

        return { rfNodes, rfEdges }
    }, [cg, displayName])

    const [nodes, , onNodesChange] = useNodesState(rfNodes)
    const [edges, , onEdgesChange] = useEdgesState(rfEdges)

    return (
        <div className="bg-surface border border-border rounded-xl p-5">
            <h2 className="text-sm font-semibold text-muted uppercase tracking-widest mb-4">
                Call Graph
            </h2>
            <div className="h-[560px] rounded-lg overflow-hidden border border-border">
                {rfNodes.length === 0 ? (
                    <div className="h-full flex items-center justify-center text-sm text-muted">
                        No call graph data for this module.
                    </div>
                ) : (
                    <ReactFlow
                        nodes={nodes}
                        edges={edges}
                        onNodesChange={onNodesChange}
                        onEdgesChange={onEdgesChange}
                        fitView
                    >
                        <Background color="#30363d" gap={24} />
                        <Controls />
                    </ReactFlow>
                )}
            </div>
        </div>
    )
}
