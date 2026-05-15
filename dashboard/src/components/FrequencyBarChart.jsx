import {
    BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer, Cell,
} from 'recharts'
import useReportStore from '../store/useReportStore'
import { getCategory, CATEGORY_COLORS } from '../utils/categories'

export default function FrequencyBarChart() {
    const report = useReportStore(s => s.report)
    const weights = useReportStore(s => s.weights)

    const data = Object.entries(report.instructions)
        .map(([op, count]) => ({
            op,
            count,
            score: count * (weights[op] ?? 1),
            color: CATEGORY_COLORS[getCategory(op)] ?? '#8b949e',
        }))
        .sort((a, b) => b.count - a.count)
        .slice(0, 20)

    return (
        <div className="bg-surface border border-border rounded-xl p-5">
            <h2 className="text-sm font-semibold text-muted uppercase tracking-widest mb-4">
                Top 20 Instructions by Frequency
            </h2>
            <ResponsiveContainer width="100%" height={320}>
                <BarChart data={data} margin={{ top: 4, right: 12, bottom: 40, left: 8 }}>
                    <XAxis
                        dataKey="op"
                        tick={{ fill: '#8b949e', fontSize: 11, fontFamily: 'JetBrains Mono' }}
                        angle={-40}
                        textAnchor="end"
                        interval={0}
                    />
                    <YAxis
                        tick={{ fill: '#8b949e', fontSize: 11 }}
                        tickFormatter={v => v.toLocaleString()}
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
                        formatter={(val, name) => [val.toLocaleString(), name]}
                    />
                    <Bar dataKey="count" radius={[4, 4, 0, 0]}>
                        {data.map((entry, i) => (
                            <Cell key={i} fill={entry.color} />
                        ))}
                    </Bar>
                </BarChart>
            </ResponsiveContainer>
        </div>
    )
}
