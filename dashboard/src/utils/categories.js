export const CATEGORIES = {
    Arithmetic: ['add', 'sub', 'mul', 'sdiv', 'udiv', 'srem', 'urem', 'neg'],
    'Float ops': ['fadd', 'fsub', 'fmul', 'fdiv', 'frem', 'fneg'],
    Memory: ['load', 'store', 'alloca', 'getelementptr', 'fence', 'atomicrmw'],
    'Control flow': ['br', 'switch', 'ret', 'call', 'invoke', 'resume', 'indirectbr'],
    Bitwise: ['and', 'or', 'xor', 'shl', 'lshr', 'ashr'],
    Comparison: ['icmp', 'fcmp', 'select'],
    Conversions: ['trunc', 'zext', 'sext', 'fpext', 'fptrunc', 'fptosi', 'sitofp', 'bitcast'],
    Vector: ['extractelement', 'insertelement', 'shufflevector'],
    Other: ['phi', 'landingpad', 'unreachable', 'va_arg'],
}

export const CATEGORY_COLORS = {
    Arithmetic: '#58a6ff',
    'Float ops': '#a371f7',
    Memory: '#f78166',
    'Control flow': '#e3b341',
    Bitwise: '#3fb950',
    Comparison: '#76e3ea',
    Conversions: '#ff9e64',
    Vector: '#c9d1d9',
    Other: '#484f58',
}

export function getCategory(opcode) {
    for (const [cat, ops] of Object.entries(CATEGORIES)) {
        if (ops.includes(opcode)) return cat
    }
    return 'Other'
}

export function groupByCategory(instrMap) {
    const result = {}
    for (const [op, count] of Object.entries(instrMap)) {
        const cat = getCategory(op)
        result[cat] = (result[cat] || 0) + count
    }
    return result
}
