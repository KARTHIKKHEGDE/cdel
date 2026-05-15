import { useState } from 'react'
import useReportStore from './store/useReportStore'
import UploadPanel from './components/UploadPanel'
import SummaryCards from './components/SummaryCards'
import FrequencyBarChart from './components/FrequencyBarChart'
import CategoryPieChart from './components/CategoryPieChart'
import FunctionTable from './components/FunctionTable'
import HeatmapGrid from './components/HeatmapGrid'
import WeightSliders from './components/WeightSliders'
import CFGViewer from './components/CFGViewer'
import ComplexityTable from './components/ComplexityTable'
import LoopAnalysis from './components/LoopAnalysis'
import CallGraph from './components/CallGraph'
import CostModelView from './components/CostModelView'
import OpcodeTimeline from './components/OpcodeTimeline'

const PAGES = [
    { id: 'overview', label: 'Overview', group: 'Core' },
    { id: 'control-flow', label: 'Control Flow', group: 'Structure' },
    { id: 'callgraph', label: 'Call Graph', group: 'Structure' },
    { id: 'timeline', label: 'Opcode Timeline', group: 'Execution' },
    { id: 'costmodel', label: 'Cost Model', group: 'Execution' },
]

export default function App() {
    const report = useReportStore(s => s.report)
    const demangleEnabled = useReportStore(s => s.demangleEnabled)
    const [page, setPage] = useState('overview')

    return (
        <div className="min-h-screen bg-bg text-gray-100">
            <header className="border-b border-border px-6 py-4 flex items-center justify-between sticky top-0 bg-bg z-10">
                <div className="flex items-center gap-3">
                    <div className="w-8 h-8 rounded bg-accent/20 flex items-center justify-center">
                        <span className="text-accent text-xs font-mono font-bold">IR</span>
                    </div>
                    <div>
                        <h1 className="font-semibold text-white text-sm">
                            Weighted Instruction Frequency Analysis
                        </h1>
                        <p className="text-xs text-muted">LLVM IR Analysis Pass - Assignment 17</p>
                    </div>
                </div>
                {report && (
                    <div className="flex items-center gap-4">
                        <label
                            className="flex items-center gap-2 cursor-pointer select-none group"
                            title="Demangle C++ symbols to readable names"
                        >
                            <div className="relative">
                                <input
                                    type="checkbox"
                                    checked={demangleEnabled}
                                    onChange={() => useReportStore.getState().toggleDemangle()}
                                    className="sr-only peer"
                                />
                                <div className="w-9 h-5 rounded-full bg-border peer-checked:bg-accent/60 transition-colors" />
                                <div className="absolute top-0.5 left-0.5 w-4 h-4 rounded-full bg-gray-400 peer-checked:bg-white peer-checked:translate-x-4 transition-all shadow-sm" />
                            </div>
                            <span className="text-xs text-muted group-hover:text-white transition-colors font-mono">
                                Demangle symbols
                            </span>
                        </label>
                        <button
                            onClick={() => useReportStore.getState().loadReport(null, '')}
                            className="text-xs text-muted hover:text-white border border-border px-3 py-1.5 rounded-lg transition-colors"
                        >
                            Load new report
                        </button>
                    </div>
                )}
            </header>

            <main className="max-w-none mx-auto px-6 py-8">
                {!report ? (
                    <div className="max-w-xl mx-auto mt-16">
                        <div className="text-center mb-10">
                            <h2 className="text-2xl font-semibold mb-2">Analyze C/C++ Source</h2>
                            <p className="text-muted text-sm">
                                Paste or drop code, the backend runs the LLVM pass for you
                            </p>
                        </div>
                        <UploadPanel />
                        <div className="mt-6 bg-surface border border-border rounded-xl p-4">
                            <p className="text-xs text-muted font-mono mb-2">Quick start:</p>
                            <pre className="text-xs text-green-400 font-mono leading-relaxed">{`# Start API + UI:
cd dashboard
npm run dev`}</pre>
                        </div>
                    </div>
                ) : (
                    <div className="grid grid-cols-1 lg:grid-cols-[240px_1fr] gap-6">
                        <aside className="lg:sticky lg:top-24 lg:self-start">
                            <div className="bg-surface border border-border rounded-xl p-4">
                                <div className="text-xs text-muted uppercase tracking-widest mb-3">Navigation</div>
                                <div className="space-y-2">
                                    {[...new Set(PAGES.map(p => p.group))].map(group => (
                                        <div key={group}>
                                            <div className="text-[10px] text-muted uppercase tracking-widest mb-2">{group}</div>
                                            <div className="flex flex-col gap-1">
                                                {PAGES.filter(p => p.group === group).map(p => (
                                                    <button
                                                        key={p.id}
                                                        onClick={() => setPage(p.id)}
                                                        className={`text-left text-sm px-3 py-2 rounded-lg transition-colors ${page === p.id
                                                            ? 'bg-accent/15 text-white border border-accent/40'
                                                            : 'text-muted hover:text-white hover:bg-white/5 border border-transparent'
                                                            }`}
                                                    >
                                                        {p.label}
                                                    </button>
                                                ))}
                                            </div>
                                        </div>
                                    ))}
                                </div>
                                <div className="mt-4 lg:hidden">
                                    <select
                                        value={page}
                                        onChange={e => setPage(e.target.value)}
                                        className="w-full bg-bg border border-border text-sm font-mono rounded-lg px-3 py-2 focus:outline-none focus:border-accent"
                                    >
                                        {PAGES.map(p => (
                                            <option key={p.id} value={p.id}>{p.label}</option>
                                        ))}
                                    </select>
                                </div>
                            </div>
                        </aside>

                        <section className="space-y-6">
                            {page === 'overview' && (
                                <>
                                    <SummaryCards />
                                    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                                        <div className="lg:col-span-2">
                                            <FrequencyBarChart />
                                        </div>
                                        <CategoryPieChart />
                                    </div>
                                    <HeatmapGrid />
                                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                                        <FunctionTable />
                                        <WeightSliders />
                                    </div>
                                </>
                            )}

                            {page === 'control-flow' && (
                                <>
                                    <CFGViewer />
                                    <div className="grid grid-cols-1 xl:grid-cols-2 gap-6">
                                        <ComplexityTable />
                                        <LoopAnalysis />
                                    </div>
                                </>
                            )}

                            {page === 'callgraph' && (
                                <>
                                    <CallGraph />
                                </>
                            )}

                            {page === 'timeline' && (
                                <>
                                    <OpcodeTimeline />
                                </>
                            )}

                            {page === 'costmodel' && (
                                <>
                                    <CostModelView />
                                </>
                            )}

                        </section>
                    </div>
                )}
            </main>
        </div>
    )
}
