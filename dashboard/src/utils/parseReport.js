export function parseReport(rawJson) {
    if (!rawJson.module) throw new Error('Missing "module" field')
    if (!rawJson.instructions) throw new Error('Missing "instructions" field')
    if (!rawJson.functions) throw new Error('Missing "functions" field')

    return {
        module: rawJson.module,
        totalInstructions: rawJson.total_instructions || 0,
        weightedScore: rawJson.weighted_score || 0,
        instructions: rawJson.instructions,
        functions: rawJson.functions.map(fn => ({
            name: fn.name,
            basicBlocks: fn.basic_blocks || 0,
            totalInstructions: fn.total_instructions || 0,
            weightedScore: fn.weighted_score || 0,
            instructions: fn.instructions || {},
        })),
        cfg: rawJson.cfg || {},
        cyclomatic_complexity: rawJson.cyclomatic_complexity || {},
        loops: rawJson.loops || {},
        call_graph: rawJson.call_graph || { nodes: [], edges: [] },
        cost_model: rawJson.cost_model || {
            total_execution_estimate: 0,
            memory_pressure_score: 0,
            bottleneck_score: 0,
            bottleneck_instructions: [],
            per_function: {},
        },
        opcode_sequence: rawJson.opcode_sequence || {},
    }
}
