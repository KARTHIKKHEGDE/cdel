import useReportStore from '../store/useReportStore'
import DemangledName from './DemangledName'

export default function LoopAnalysis() {
    const report = useReportStore(s => s.report)
    const loops = report.loops || {}
    const allLoops = Object.entries(loops).flatMap(([fn, ls]) =>
        (ls || []).map(l => ({
            fn,
            ...l,
            instructionCount: l.instructionCount ?? l.instruction_count ?? 0,
            weightedScore: l.weightedScore ?? l.weighted_score ?? 0,
            backEdges: l.backEdges ?? l.back_edges ?? [],
        }))
    ).sort((a, b) => b.weightedScore - a.weightedScore)

    if (allLoops.length === 0) {
        return (
            <div className="bg-surface border border-border rounded-xl p-5">
                <h2 className="text-sm font-semibold text-muted uppercase tracking-widest mb-4">Loop Analysis</h2>
                <p className="text-muted text-sm">No loops detected in this module.</p>
            </div>
        )
    }

    return (
        <div className="bg-surface border border-border rounded-xl p-5">
            <h2 className="text-sm font-semibold text-muted uppercase tracking-widest mb-4">
                Loop Analysis
            </h2>
            <div className="space-y-3">
                {allLoops.map((loop, i) => (
                    <div key={i} className="border border-border rounded-lg p-4">
                        <div className="flex items-start justify-between mb-2">
                            <div className="font-mono text-sm">
                                <DemangledName name={loop.fn} className="text-accent" showMangled inline />
                                <span className="text-muted text-xs mx-2">-&gt;</span>
                                <span className="text-white">{loop.header}</span>
                            </div>
                            <div className="flex gap-2">
                                <span className="text-xs px-2 py-0.5 rounded bg-blue-900 text-blue-300">
                                    depth {loop.depth}
                                </span>
                                {loop.isInnermost && (
                                    <span className="text-xs px-2 py-0.5 rounded bg-purple-900 text-purple-300">
                                        innermost
                                    </span>
                                )}
                            </div>
                        </div>
                        <div className="grid grid-cols-3 gap-3 text-xs">
                            <div>
                                <div className="text-muted mb-0.5">Instructions</div>
                                <div className="font-mono text-white">{loop.instructionCount}</div>
                            </div>
                            <div>
                                <div className="text-muted mb-0.5">Weighted score</div>
                                <div className="font-mono text-warm">{Number(loop.weightedScore).toFixed(1)}</div>
                            </div>
                            <div>
                                <div className="text-muted mb-0.5">Back edges</div>
                                <div className="font-mono text-hot">{loop.backEdges.length}</div>
                            </div>
                        </div>
                        {loop.backEdges.length > 0 && (
                            <div className="mt-2 flex flex-wrap gap-1.5">
                                {loop.backEdges.map((be, j) => (
                                    <span key={j} className="font-mono text-xs bg-bg border border-border px-2 py-0.5 rounded">
                                        <span className="text-hot">{be.from ?? be.from_block ?? ''}</span>
                                        <span className="text-muted"> -&gt; </span>
                                        <span className="text-green-400">{be.to ?? be.to_block ?? ''}</span>
                                    </span>
                                ))}
                            </div>
                        )}
                    </div>
                ))}
            </div>
        </div>
    )
}
