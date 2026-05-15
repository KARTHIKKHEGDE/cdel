import { useState } from 'react'
import useReportStore from '../store/useReportStore'
import { getCategory, CATEGORY_COLORS } from '../utils/categories'

export default function OpcodeTimeline() {
    const report = useReportStore(s => s.report)
    const displayName = useReportStore(s => s.displayName)
    const seqs = report.opcode_sequence || {}
    const fns = Object.keys(seqs)
    const [selectedFn, setSelectedFn] = useState(fns[0] || '')
    const [hoveredOp, setHoveredOp] = useState(null)

    const seq = seqs[selectedFn] || []
    const label = displayName(selectedFn)
    const isDemangled = label !== selectedFn

    return (
        <div className="bg-surface border border-border rounded-xl p-5">
            <div className="flex items-center justify-between mb-4">
                <h2 className="text-sm font-semibold text-muted uppercase tracking-widest">
                    Opcode Execution Timeline
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

            {/* Show mangled name when demangled */}
            {isDemangled && (
                <div className="mb-3 text-[11px] text-muted font-mono bg-bg/60 border border-border/50 rounded px-3 py-1.5 flex items-center gap-2">
                    <span className="text-accent/70">mangled:</span>
                    <span>{selectedFn}</span>
                </div>
            )}

            <div className="overflow-x-auto pb-3">
                <div className="flex items-center gap-1 min-w-max">
                    {seq.map((op, i) => {
                        const cat = getCategory(op)
                        const color = CATEGORY_COLORS[cat] || '#484f58'
                        const isHot = ['call', 'sdiv', 'udiv', 'fdiv'].includes(op)
                        return (
                            <div key={i} className="flex flex-col items-center gap-1">
                                <div
                                    onMouseEnter={() => setHoveredOp({ op, i, color })}
                                    onMouseLeave={() => setHoveredOp(null)}
                                    className="relative cursor-default"
                                >
                                    <div
                                        className={`
                      px-2 py-1.5 rounded font-mono text-xs whitespace-nowrap
                      transition-transform hover:scale-110 hover:-translate-y-1
                      ${isHot ? 'ring-1 ring-red-500' : ''}
                    `}
                                        style={{
                                            background: `${color}33`,
                                            border: `1px solid ${color}66`,
                                            color,
                                            minWidth: 44,
                                            textAlign: 'center',
                                        }}
                                    >
                                        {op}
                                    </div>
                                </div>
                                <div className="text-muted text-xs" style={{ fontSize: 9 }}>
                                    {i + 1}
                                </div>
                            </div>
                        )
                    })}
                </div>
            </div>

            {hoveredOp && (
                <div className="mt-3 bg-bg border border-border rounded-lg px-3 py-2 text-xs font-mono inline-flex gap-3">
                    <span className="text-muted">Step {hoveredOp.i + 1}</span>
                    <span style={{ color: hoveredOp.color }}>{hoveredOp.op}</span>
                    <span className="text-muted">{getCategory(hoveredOp.op)}</span>
                </div>
            )}

            {seq.some(op => ['call', 'sdiv', 'udiv', 'fdiv'].includes(op)) && (
                <div className="mt-3 text-xs text-red-400 flex items-center gap-1.5">
                    <span className="w-2 h-2 rounded-full bg-red-500 inline-block" />
                    Red outlined boxes are high latency instructions
                </div>
            )}
        </div>
    )
}
