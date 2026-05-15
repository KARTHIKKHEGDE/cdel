import useReportStore from '../store/useReportStore'

export default function HeatmapGrid() {
    const fns = useReportStore(s => s.computedFunctions())
    const weights = useReportStore(s => s.weights)
    const displayName = useReportStore(s => s.displayName)

    const allOps = [...new Set(fns.flatMap(fn => Object.keys(fn.instructions)))].sort()
    if (fns.length === 0 || allOps.length === 0) return null

    const maxScore = Math.max(
        ...fns.flatMap(fn =>
            allOps.map(op => (fn.instructions[op] || 0) * (weights[op] ?? 1))
        )
    )

    const cellColor = (score) => {
        if (score === 0) return 'bg-bg'
        const pct = score / maxScore
        if (pct > 0.75) return 'bg-red-700'
        if (pct > 0.5) return 'bg-orange-600'
        if (pct > 0.25) return 'bg-yellow-600'
        if (pct > 0.05) return 'bg-green-800'
        return 'bg-green-950'
    }

    const topOps = allOps
        .map(op => ({ op, total: fns.reduce((s, fn) => s + (fn.instructions[op] || 0), 0) }))
        .sort((a, b) => b.total - a.total)
        .slice(0, 15)
        .map(x => x.op)

    return (
        <div className="bg-surface border border-border rounded-xl p-5 overflow-x-auto">
            <h2 className="text-sm font-semibold text-muted uppercase tracking-widest mb-4">
                Instruction Heatmap - functions x opcodes (weighted score)
            </h2>
            <table className="text-xs font-mono border-collapse">
                <thead>
                    <tr>
                        <th className="text-left text-muted pr-3 pb-1 min-w-[120px]">Function</th>
                        {topOps.map(op => (
                            <th
                                key={op}
                                className="text-muted pb-1 px-1 font-normal"
                                style={{ writingMode: 'vertical-rl', transform: 'rotate(180deg)', height: 80 }}
                            >
                                {op}
                            </th>
                        ))}
                    </tr>
                </thead>
                <tbody>
                    {fns.map(fn => (
                        <tr key={fn.name}>
                            <td className="pr-3 py-0.5 text-accent truncate max-w-[180px]" title={fn.name}>
                                {displayName(fn.name)}
                            </td>
                            {topOps.map(op => {
                                const score = (fn.instructions[op] || 0) * (weights[op] ?? 1)
                                return (
                                    <td key={op} className="px-0.5 py-0.5">
                                        <div
                                            className={`w-7 h-5 rounded-sm ${cellColor(score)} flex items-center justify-center`}
                                            title={`${displayName(fn.name)} · ${op}: count=${fn.instructions[op] || 0} score=${score.toFixed(1)}`}
                                        ></div>
                                    </td>
                                )
                            })}
                        </tr>
                    ))}
                </tbody>
            </table>
            <div className="flex items-center gap-2 mt-3 text-xs text-muted">
                <span>Low</span>
                {['bg-green-950', 'bg-green-800', 'bg-yellow-600', 'bg-orange-600', 'bg-red-700'].map(c => (
                    <div key={c} className={`w-5 h-3 rounded-sm ${c}`} />
                ))}
                <span>High</span>
            </div>
        </div>
    )
}
