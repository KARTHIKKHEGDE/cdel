/**
 * Demangle C++ mangled symbols by calling the backend /api/demangle endpoint.
 * Returns a mapping { mangledName: demangledName }.
 */
export async function fetchDemangled(symbols) {
    if (!symbols || symbols.length === 0) return {}

    try {
        const res = await fetch('/api/demangle', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ symbols }),
        })
        if (!res.ok) return identityMap(symbols)
        const data = await res.json()
        return data.mapping || identityMap(symbols)
    } catch {
        return identityMap(symbols)
    }
}

function identityMap(symbols) {
    const map = {}
    symbols.forEach(s => { map[s] = s })
    return map
}

/**
 * Collect all unique function/symbol names from a parsed report.
 */
export function collectSymbols(report) {
    if (!report) return []
    const names = new Set()

    // from functions array
    ;(report.functions || []).forEach(fn => names.add(fn.name))

    // from cfg keys
    Object.keys(report.cfg || {}).forEach(fn => names.add(fn))

    // from cyclomatic_complexity keys
    Object.keys(report.cyclomatic_complexity || {}).forEach(fn => names.add(fn))

    // from loops keys
    Object.keys(report.loops || {}).forEach(fn => names.add(fn))

    // from call_graph nodes
    ;(report.call_graph?.nodes || []).forEach(n => names.add(n))

    // from cost_model per_function keys
    Object.keys(report.cost_model?.per_function || {}).forEach(fn => names.add(fn))

    // from opcode_sequence keys
    Object.keys(report.opcode_sequence || {}).forEach(fn => names.add(fn))

    return [...names]
}

/**
 * Display helper: given a mangled name and a demangle map,
 * returns { display, mangled, isDemangled }
 */
export function demangleDisplay(name, demangleMap, showDemangled) {
    if (!showDemangled || !demangleMap || !demangleMap[name]) {
        return { display: name, mangled: name, isDemangled: false }
    }
    const demangled = demangleMap[name]
    const changed = demangled !== name
    return {
        display: changed ? demangled : name,
        mangled: name,
        isDemangled: changed,
    }
}
