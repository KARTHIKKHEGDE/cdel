import { PieChart, Pie, Cell, Tooltip, ResponsiveContainer, Legend } from 'recharts'
import useReportStore from '../store/useReportStore'
import { groupByCategory, CATEGORY_COLORS } from '../utils/categories'

export default function CategoryPieChart() {
    const report = useReportStore(s => s.report)
    const grouped = groupByCategory(report.instructions)

    const data = Object.entries(grouped)
        .map(([name, value]) => ({ name, value }))
        .filter(d => d.value > 0)
        .sort((a, b) => b.value - a.value)

    return (
        <div className="bg-surface border border-border rounded-xl p-5">
            <h2 className="text-sm font-semibold text-muted uppercase tracking-widest mb-4">
                Instruction Category Breakdown
            </h2>
            <ResponsiveContainer width="100%" height={280}>
                <PieChart>
                    <Pie
                        data={data}
                        cx="50%"
                        cy="45%"
                        innerRadius={60}
                        outerRadius={100}
                        paddingAngle={2}
                        dataKey="value"
                    >
                        {data.map((entry, i) => (
                            <Cell key={i} fill={CATEGORY_COLORS[entry.name] ?? '#484f58'} />
                        ))}
                    </Pie>
                    <Tooltip
                        contentStyle={{
                            background: '#161b22',
                            border: '1px solid #30363d',
                            borderRadius: 8,
                            fontSize: 12,
                            color: '#e5e7eb',
                        }}
                        labelStyle={{ color: '#e5e7eb' }}
                        itemStyle={{ color: '#e5e7eb' }}
                        formatter={(v) => [v.toLocaleString(), 'instructions']}
                    />
                    <Legend
                        iconType="square"
                        iconSize={10}
                        wrapperStyle={{ fontSize: 12, color: '#8b949e' }}
                    />
                </PieChart>
            </ResponsiveContainer>
        </div>
    )
}
