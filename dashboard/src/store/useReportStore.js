import { create } from 'zustand'
import { fetchDemangled, collectSymbols } from '../utils/demangle'

const BUILT_IN_WEIGHTS = {
    add: 1, sub: 1, mul: 3, sdiv: 5, udiv: 5, srem: 5, urem: 5,
    fadd: 2, fsub: 2, fmul: 4, fdiv: 8,
    alloca: 1, load: 2, store: 3, getelementptr: 2,
    br: 1, switch: 2, ret: 1, call: 10, invoke: 10,
    and: 1, or: 1, xor: 1, shl: 1, lshr: 1, ashr: 1,
    icmp: 1, fcmp: 2, select: 2,
    trunc: 1, zext: 1, sext: 1, bitcast: 0.5,
    phi: 1, unreachable: 0,
}

const useReportStore = create((set, get) => ({
    report: null,
    weights: {},
    fileName: '',
    demangleMap: {},
    demangleEnabled: true,

    loadReport: (report, fileName) => {
        if (!report) {
            set({ report: null, fileName: '', weights: {}, demangleMap: {} })
            return
        }

        const defaultWeights = {}
        Object.keys(report.instructions || {}).forEach(op => {
            defaultWeights[op] = BUILT_IN_WEIGHTS[op] ?? 1.0
        })
        set({ report, fileName, weights: defaultWeights })

        // Automatically demangle all symbols in the report
        const symbols = collectSymbols(report)
        if (symbols.length > 0) {
            fetchDemangled(symbols).then(mapping => {
                set({ demangleMap: mapping })
            })
        }
    },

    setWeight: (opcode, value) => {
        set(state => ({
            weights: { ...state.weights, [opcode]: Number(value) },
        }))
    },

    toggleDemangle: () => {
        set(state => ({ demangleEnabled: !state.demangleEnabled }))
    },

    /** Get the display name for a symbol, respecting the demangle toggle */
    displayName: (name) => {
        const { demangleMap, demangleEnabled } = get()
        if (!demangleEnabled || !demangleMap[name]) return name
        return demangleMap[name]
    },

    computedScore: () => {
        const { report, weights } = get()
        if (!report) return 0
        return Object.entries(report.instructions).reduce((total, [op, count]) => {
            return total + count * (weights[op] ?? 1.0)
        }, 0)
    },

    computedFunctions: () => {
        const { report, weights } = get()
        if (!report) return []
        return report.functions
            .map(fn => ({
                ...fn,
                computedScore: Object.entries(fn.instructions).reduce((s, [op, cnt]) => {
                    return s + cnt * (weights[op] ?? 1.0)
                }, 0),
            }))
            .sort((a, b) => b.computedScore - a.computedScore)
    },
}))

export default useReportStore
