import useReportStore from '../store/useReportStore'
import DemangledName from './DemangledName'

function badge(complexity) {
    if (complexity <= 5) return { label: 'Simple', cls: 'bg-green-900 text-green-300' }
    if (complexity <= 10) return { label: 'Moderate', cls: 'bg-yellow-900 text-yellow-300' }
    return { label: 'Complex', cls: 'bg-red-900 text-red-300' }
}

export default function ComplexityTable() {
    const report = useReportStore(s => s.report)
    const cc = report.cyclomatic_complexity || {}

    const rows = Object.entries(cc)
        .map(([fn, data]) => ({ fn, ...data }))
        .sort((a, b) => b.complexity - a.complexity)

    return (
        <div className="bg-surface border border-border rounded-xl p-5">
            <h2 className="text-sm font-semibold text-muted uppercase tracking-widest mb-4">
                Cyclomatic Complexity - M = E - N + 2P
            </h2>
            <div className="overflow-x-auto">
                <table className="w-full text-sm font-mono">
                    <thead>
                        <tr className="border-b border-border text-muted text-left">
                            <th className="pb-2 pr-6">Function</th>
                            <th className="pb-2 pr-6 text-right">M</th>
                            <th className="pb-2 pr-6 text-right">Edges (E)</th>
                            <th className="pb-2 pr-6 text-right">Nodes (N)</th>
                            <th className="pb-2">Risk</th>
                        </tr>
                    </thead>
                    <tbody>
                        {rows.map(row => {
                            const b = badge(row.complexity)
                            return (
                                <tr key={row.fn} className="border-b border-border/40 hover:bg-white/5">
                                    <td className="py-2 pr-6 text-accent">
                                        <DemangledName name={row.fn} showMangled />
                                    </td>
                                    <td className="py-2 pr-6 text-right font-bold text-white text-base">
                                        {row.complexity}
                                    </td>
                                    <td className="py-2 pr-6 text-right text-muted">{row.edges}</td>
                                    <td className="py-2 pr-6 text-right text-muted">{row.nodes}</td>
                                    <td className="py-2">
                                        <span className={`px-2 py-0.5 rounded text-xs font-medium ${b.cls}`}>
                                            {b.label}
                                        </span>
                                    </td>
                                </tr>
                            )
                        })}
                    </tbody>
                </table>
            </div>
            <div className="mt-4 grid grid-cols-3 gap-3 text-xs">
                <div className="bg-green-900/30 border border-green-800 rounded-lg p-3 text-green-300">
                    <div className="font-medium mb-1">M &lt;= 5 - Simple</div>
                    <div className="text-green-400/70">Easy to test and maintain</div>
                </div>
                <div className="bg-yellow-900/30 border border-yellow-800 rounded-lg p-3 text-yellow-300">
                    <div className="font-medium mb-1">M 6-10 - Moderate</div>
                    <div className="text-yellow-400/70">Consider refactoring</div>
                </div>
                <div className="bg-red-900/30 border border-red-800 rounded-lg p-3 text-red-300">
                    <div className="font-medium mb-1">M &gt; 10 - High risk</div>
                    <div className="text-red-400/70">Hard to test and maintain</div>
                </div>
            </div>
        </div>
    )
}
