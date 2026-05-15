import { useEffect, useMemo, useState } from 'react'
import {
    ReactFlow,
    Background,
    Controls,
    MiniMap,
    MarkerType,
    useNodesState,
    useEdgesState,
} from '@xyflow/react'
import useReportStore from '../store/useReportStore'

const NODE_WIDTH = 160
const NODE_HEIGHT = 60
const H_GAP = 60
const V_GAP = 80

function layoutGraph(nodes, edges) {
    const adj = {}
    const inDeg = {}
    nodes.forEach(n => {
        adj[n.id] = []
        inDeg[n.id] = 0
    })
    edges.forEach(e => {
        if (e.type !== 'back_edge') {
            adj[e.source]?.push(e.target)
            inDeg[e.target] = (inDeg[e.target] || 0) + 1
        }
    })

    const level = {}
    const queue = nodes.filter(n => inDeg[n.id] === 0).map(n => n.id)
    queue.forEach(id => { level[id] = 0 })

    while (queue.length) {
        const cur = queue.shift()
            ; (adj[cur] || []).forEach(next => {
                if (level[next] === undefined) {
                    level[next] = (level[cur] || 0) + 1
                    queue.push(next)
                }
            })
    }
    nodes.forEach(n => {
        if (level[n.id] === undefined) level[n.id] = 0
    })

    const levelGroups = {}
    nodes.forEach(n => {
        const l = level[n.id]
        if (!levelGroups[l]) levelGroups[l] = []
        levelGroups[l].push(n.id)
    })

    const pos = {}
    Object.entries(levelGroups).forEach(([lv, ids]) => {
        const totalW = ids.length * NODE_WIDTH + (ids.length - 1) * H_GAP
        ids.forEach((id, i) => {
            pos[id] = {
                x: -totalW / 2 + i * (NODE_WIDTH + H_GAP),
                y: Number(lv) * (NODE_HEIGHT + V_GAP),
            }
        })
    })
    return pos
}

const nodeColors = {
    entry: '#1f6feb',
    exit: '#3fb950',
    ret: '#3fb950',
}

export default function CFGViewer() {
    const report = useReportStore(s => s.report)
    const displayName = useReportStore(s => s.displayName)
    const [selectedFn, setSelectedFn] = useState(
        Object.keys(report.cfg || {})[0] || ''
    )

    useEffect(() => {
        const fns = Object.keys(report.cfg || {})
        if (!selectedFn && fns.length > 0) {
            setSelectedFn(fns[0])
        }
        if (selectedFn && fns.length > 0 && !fns.includes(selectedFn)) {
            setSelectedFn(fns[0])
        }
    }, [report, selectedFn])

    const { rfNodes, rfEdges, hasData } = useMemo(() => {
        if (!report?.cfg || !report.cfg[selectedFn]) {
            return { rfNodes: [], rfEdges: [], hasData: false }
        }

        const rawNodes = report.cfg[selectedFn]?.nodes || []
        const rawEdges = report.cfg[selectedFn]?.edges || []
        if (rawNodes.length === 0) {
            return { rfNodes: [], rfEdges: [], hasData: false }
        }

        const pos = layoutGraph(rawNodes, rawEdges)

        const rfNodes = rawNodes.map(n => ({
            id: n.id,
            position: pos[n.id] || { x: 0, y: 0 },
            data: {
                label: (
                    <div className="text-left">
                        <div className="text-xs font-semibold text-white mb-1">{n.label}</div>
                        <div className="space-y-0.5">
                            {(n.ops || []).slice(0, 8).map((op, idx) => (
                                <div key={idx} className="text-[10px] text-gray-300 font-mono">
                                    {op}
                                </div>
                            ))}
                            {(n.ops || []).length > 8 && (
                                <div className="text-[10px] text-muted">+{(n.ops || []).length - 8} more</div>
                            )}
                        </div>
                    </div>
                ),
            },
            style: {
                background: nodeColors[n.id] || '#161b22',
                border: `1px solid ${nodeColors[n.id] || '#30363d'}`,
                borderRadius: 8,
                color: '#e6edf3',
                fontSize: 12,
                fontFamily: 'JetBrains Mono',
                padding: '10px 12px',
                width: 220,
                textAlign: 'center',
            },
        }))

        const rfEdges = rawEdges.map((e, i) => ({
            id: `e${i}`,
            source: e.source,
            target: e.target,
            label: e.type === 'back_edge' ? 'back' : (e.type === 'true' ? 'T' : e.type === 'false' ? 'F' : ''),
            style: {
                stroke: e.type === 'back_edge' ? '#f78166'
                    : e.type === 'true' ? '#3fb950'
                        : e.type === 'false' ? '#e3b341'
                            : '#58a6ff',
                strokeWidth: e.type === 'back_edge' ? 2 : 1.5,
                strokeDasharray: e.type === 'back_edge' ? '5 3' : undefined,
            },
            markerEnd: {
                type: MarkerType.ArrowClosed,
                color: e.type === 'back_edge' ? '#f78166' : '#58a6ff',
            },
            animated: e.type === 'back_edge',
        }))

        return { rfNodes, rfEdges, hasData: true }
    }, [report, selectedFn])

    const [nodes, , onNodesChange] = useNodesState(rfNodes)
    const [edges, , onEdgesChange] = useEdgesState(rfEdges)

    const fns = Object.keys(report.cfg || {})

    return (
        <div className="bg-surface border border-border rounded-xl p-5">
            <div className="flex items-center justify-between mb-4">
                <h2 className="text-sm font-semibold text-muted uppercase tracking-widest">
                    Control Flow Graph
                </h2>
                <select
                    value={selectedFn}
                    onChange={e => setSelectedFn(e.target.value)}
                    className="bg-bg border border-border text-sm font-mono rounded-lg px-3 py-1.5 focus:outline-none focus:border-accent max-w-[360px] truncate"
                    title={selectedFn}
                >
                    {fns.map(fn => (
                        <option key={fn} value={fn}>
                            {displayName(fn)}
                        </option>
                    ))}
                </select>
            </div>

            {/* Show mangled name below if demangled */}
            {selectedFn && displayName(selectedFn) !== selectedFn && (
                <div className="mb-3 text-[11px] text-muted font-mono bg-bg/60 border border-border/50 rounded px-3 py-1.5 flex items-center gap-2">
                    <span className="text-accent/70">mangled:</span>
                    <span>{selectedFn}</span>
                </div>
            )}

            <div className="h-[560px] rounded-lg overflow-hidden border border-border">
                {!hasData ? (
                    <div className="h-full flex items-center justify-center text-sm text-muted">
                        No CFG data available for this module.
                    </div>
                ) : (
                    <ReactFlow
                        nodes={nodes}
                        edges={edges}
                        onNodesChange={onNodesChange}
                        onEdgesChange={onEdgesChange}
                        fitView
                        attributionPosition="bottom-right"
                    >
                        <Background color="#30363d" gap={24} />
                        <Controls />
                        <MiniMap
                            nodeColor={n => n.style?.background || '#161b22'}
                            style={{ background: '#0d1117', border: '1px solid #30363d' }}
                        />
                    </ReactFlow>
                )}
            </div>

            <div className="flex gap-4 mt-3 text-xs text-muted">
                <span className="flex items-center gap-1.5"><span className="w-4 h-0.5 bg-green-500 inline-block" /> True branch</span>
                <span className="flex items-center gap-1.5"><span className="w-4 h-0.5 bg-yellow-500 inline-block" /> False branch</span>
                <span className="flex items-center gap-1.5"><span className="w-4 h-0.5 bg-red-400 border-dashed inline-block" /> Back edge</span>
                <span className="flex items-center gap-1.5"><span className="w-4 h-0.5 bg-accent inline-block" /> Unconditional</span>
            </div>
        </div>
    )
}
