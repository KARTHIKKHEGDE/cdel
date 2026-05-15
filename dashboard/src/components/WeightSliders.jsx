import { useState } from 'react'
import useReportStore from '../store/useReportStore'
import { getCategory, CATEGORY_COLORS } from '../utils/categories'
import { Slider } from './ui/slider'

export default function WeightSliders() {
    const report = useReportStore(s => s.report)
    const weights = useReportStore(s => s.weights)
    const setWeight = useReportStore(s => s.setWeight)
    const [filter, setFilter] = useState('')

    const ops = Object.keys(report.instructions)
        .filter(op => op.toLowerCase().includes(filter.toLowerCase()))
        .sort((a, b) => report.instructions[b] - report.instructions[a])

    return (
        <div className="bg-surface border border-border rounded-xl p-5">
            <h2 className="text-sm font-semibold text-muted uppercase tracking-widest mb-4">
                Dynamic Weight Editor
            </h2>
            <input
                type="text"
                placeholder="Filter opcodes..."
                value={filter}
                onChange={e => setFilter(e.target.value)}
                className="w-full bg-bg border border-border rounded-lg px-3 py-2 text-sm font-mono mb-4 focus:outline-none focus:border-accent"
            />
            <div className="space-y-3 max-h-96 overflow-y-auto pr-1">
                {ops.map(op => {
                    const cat = getCategory(op)
                    const color = CATEGORY_COLORS[cat] ?? '#8b949e'
                    const count = report.instructions[op]
                    const w = weights[op] ?? 1

                    return (
                        <div key={op} className="flex items-center gap-3">
                            <div className="w-3 h-3 rounded-sm flex-shrink-0" style={{ background: color }} />
                            <span className="font-mono text-xs text-accent w-24 flex-shrink-0">{op}</span>
                            <span className="text-xs text-muted w-12 flex-shrink-0 text-right">x{count}</span>
                            <Slider
                                value={[Number(w)]}
                                min={0}
                                max={20}
                                step={0.5}
                                onValueChange={(value) => setWeight(op, value[0])}
                                className="flex-1"
                            />
                            <span className="font-mono text-xs text-warm w-8 text-right flex-shrink-0">
                                {Number(w).toFixed(1)}
                            </span>
                        </div>
                    )
                })}
            </div>
        </div>
    )
}
