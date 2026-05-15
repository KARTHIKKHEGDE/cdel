import useReportStore from '../store/useReportStore'
import DemangledName from './DemangledName'

function Card({ label, value, sub, accent, isSymbol }) {
    return (
        <div className="bg-surface border border-border rounded-xl p-5">
            <p className="text-xs text-muted uppercase tracking-widest mb-1">{label}</p>
            <p className={`text-3xl font-mono font-semibold ${accent || 'text-white'}`}>
                {isSymbol ? (
                    <DemangledName name={value} className="text-2xl" />
                ) : (
                    value
                )}
            </p>
            {sub && <p className="text-xs text-muted mt-1">{sub}</p>}
        </div>
    )
}

export default function SummaryCards() {
    const report = useReportStore(s => s.report)
    const fileName = useReportStore(s => s.fileName)
    const computed = useReportStore(s => s.computedScore())
    const fns = useReportStore(s => s.computedFunctions())

    const hotFn = fns[0]

    return (
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <Card
                label="Module"
                value={report.module.replace(/.*\//, '')}
                sub={fileName}
                accent="text-accent"
            />
            <Card
                label="Total instructions"
                value={report.totalInstructions.toLocaleString()}
                sub={`${Object.keys(report.instructions).length} unique opcodes`}
            />
            <Card
                label="Weighted score"
                value={computed.toFixed(0)}
                sub="with current weight sliders"
                accent="text-warm"
            />
            <Card
                label="Hottest function"
                value={hotFn?.name ?? '—'}
                sub={hotFn ? `score ${hotFn.computedScore.toFixed(0)}` : ''}
                accent="text-hot"
                isSymbol={!!hotFn}
            />
        </div>
    )
}
