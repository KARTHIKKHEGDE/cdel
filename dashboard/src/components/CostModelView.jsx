import {
    BarChart,
    Bar,
    XAxis,
    YAxis,
    Tooltip,
    ResponsiveContainer,
} from 'recharts'
import useReportStore from '../store/useReportStore'

export default function CostModelView() {
    const report = useReportStore(s => s.report)
    const displayName = useReportStore(s => s.displayName)
    const cm = report.cost_model || {}

    const fnData = Object.entries(cm.per_function || {})
        .map(([name, v]) => ({
            name,
            label: displayName(name),
            exec: v.execution_estimate,
            memory: v.memory_pressure,
        }))
        .sort((a, b) => b.exec - a.exec)

    return (
        <div className="bg-surface border border-border rounded-xl p-5">
            <h2 className="text-sm font-semibold text-muted uppercase tracking-widest mb-4">
                Instruction Cost Model
            </h2>

            <div className="grid grid-cols-3 gap-4 mb-6">
                <div className="bg-bg border border-border rounded-lg p-3">
                    <div className="text-xs text-muted mb-1">Execution estimate</div>
                    <div className="font-mono text-xl text-white">
                        {(cm.total_execution_estimate || 0).toFixed(0)}
                    </div>
                    <div className="text-xs text-muted">cycles (approx)</div>
                </div>
                <div className="bg-bg border border-border rounded-lg p-3">
                    <div className="text-xs text-muted mb-1">Memory pressure</div>
                    <div className="font-mono text-xl text-hot">
                        {(cm.memory_pressure_score || 0).toFixed(0)}
                    </div>
                    <div className="text-xs text-muted">load/store costs</div>
                </div>
                <div className="bg-bg border border-border rounded-lg p-3">
                    <div className="text-xs text-muted mb-1">Bottleneck score</div>
                    <div className="font-mono text-xl text-warm">
                        {(cm.bottleneck_score || 0).toFixed(0)}
                    </div>
                    <div className="text-xs text-muted">
                        {(cm.bottleneck_instructions || []).slice(0, 3).join(', ')}
                    </div>
                </div>
            </div>

            <div className="text-xs text-muted uppercase mb-2">Execution estimate per function</div>
            <ResponsiveContainer width="100%" height={Math.max(220, fnData.length * 36)}>
                <BarChart data={fnData} layout="vertical"
                    margin={{ top: 0, right: 16, bottom: 0, left: 160 }}>
                    <XAxis type="number" tick={{ fill: '#8b949e', fontSize: 11 }}
                        tickFormatter={v => v.toLocaleString()} />
                    <YAxis
                        type="category"
                        dataKey="label"
                        width={155}
                        tick={{ fill: '#58a6ff', fontSize: 11, fontFamily: 'JetBrains Mono' }}
                        tickFormatter={v => v.length > 22 ? v.slice(0, 21) + '…' : v}
                    />
                    <Tooltip
                        contentStyle={{
                            background: '#161b22',
                            border: '1px solid #30363d',
                            borderRadius: 8,
                            fontFamily: 'JetBrains Mono',
                            fontSize: 12,
                            color: '#e5e7eb',
                        }}
                        labelStyle={{ color: '#e5e7eb' }}
                        itemStyle={{ color: '#e5e7eb' }}
                        labelFormatter={(label, payload) => {
                            const entry = payload?.[0]?.payload
                            if (entry && entry.name !== entry.label) {
                                return `${label}\n(${entry.name})`
                            }
                            return label
                        }}
                        formatter={(v, name) => [v.toFixed(1), name === 'exec' ? 'execution' : 'memory']}
                    />
                    <Bar dataKey="exec" name="exec" stackId="a" fill="#58a6ff" radius={[0, 4, 4, 0]} />
                    <Bar dataKey="memory" name="memory" stackId="a" fill="#f78166" radius={[0, 4, 4, 0]} />
                </BarChart>
            </ResponsiveContainer>
        </div>
    )
}
