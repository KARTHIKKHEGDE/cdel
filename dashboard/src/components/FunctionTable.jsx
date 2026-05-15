import { Fragment, useState } from 'react'
import { ChevronDown, ChevronUp } from 'lucide-react'
import useReportStore from '../store/useReportStore'
import DemangledName from './DemangledName'
import {
    Table,
    TableBody,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
} from './ui/table'

export default function FunctionTable() {
    const fns = useReportStore(s => s.computedFunctions())
    const [expanded, setExpanded] = useState(null)

    return (
        <div className="bg-surface border border-border rounded-xl p-5">
            <h2 className="text-sm font-semibold text-muted uppercase tracking-widest mb-4">
                Per-Function Breakdown
            </h2>
            <div className="overflow-x-auto">
                <Table className="text-sm font-mono">
                    <TableHeader>
                        <TableRow className="border-border text-muted">
                            <TableHead className="pr-4">Function</TableHead>
                            <TableHead className="text-right pr-4">Basic blocks</TableHead>
                            <TableHead className="text-right pr-4">Instructions</TableHead>
                            <TableHead className="text-right pr-4">Weighted score</TableHead>
                            <TableHead className="text-right"></TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        {fns.map((fn, i) => (
                            <Fragment key={fn.name}>
                                <TableRow
                                    key={fn.name}
                                    className="border-border/50 hover:bg-white/5 cursor-pointer"
                                    onClick={() => setExpanded(expanded === i ? null : i)}
                                >
                                    <TableCell className="pr-4 text-accent">
                                        <DemangledName name={fn.name} showMangled />
                                    </TableCell>
                                    <TableCell className="text-right pr-4">{fn.basicBlocks}</TableCell>
                                    <TableCell className="text-right pr-4">{fn.totalInstructions}</TableCell>
                                    <TableCell className="text-right pr-4 text-warm font-semibold">
                                        {fn.computedScore.toFixed(1)}
                                    </TableCell>
                                    <TableCell className="text-right text-muted">
                                        {expanded === i ? <ChevronUp size={14} /> : <ChevronDown size={14} />}
                                    </TableCell>
                                </TableRow>
                                {expanded === i && (
                                    <TableRow key={fn.name + '-detail'}>
                                        <TableCell colSpan={5} className="bg-bg/50 px-4 py-3">
                                            <div className="flex flex-wrap gap-2">
                                                {Object.entries(fn.instructions)
                                                    .sort((a, b) => b[1] - a[1])
                                                    .map(([op, count]) => (
                                                        <span
                                                            key={op}
                                                            className="px-2 py-0.5 rounded bg-border text-xs text-gray-300"
                                                        >
                                                            {op} <span className="text-hot">{count}</span>
                                                        </span>
                                                    ))}
                                            </div>
                                        </TableCell>
                                    </TableRow>
                                )}
                            </Fragment>
                        ))}
                    </TableBody>
                </Table>
            </div>
        </div>
    )
}
