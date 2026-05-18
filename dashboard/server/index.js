import express from 'express'
import { execFile } from 'child_process'
import fs from 'fs/promises'
import { existsSync } from 'fs'
import os from 'os'
import path from 'path'
import { fileURLToPath } from 'url'

const app = express()
app.use(express.json({ limit: '5mb' }))

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const rootDir = path.resolve(__dirname, '..', '..')
const passDir = path.join(rootDir, 'pass')
const pluginPath = path.join(passDir, 'output', 'libWeightedFreqPass.so')
const port = Number(process.env.WIFA_PORT || 3001)

function runCommand(command, args, options = {}) {
    return new Promise((resolve, reject) => {
        execFile(command, args, { ...options, maxBuffer: 1024 * 1024 }, (err, stdout, stderr) => {
            if (err) {
                const msg = (stderr || err.message || '').trim()
                err.message = msg || `Failed to run ${command}`
                return reject(err)
            }
            resolve({ stdout, stderr })
        })
    })
}

function inferLanguage(filename, language) {
    if (language === 'cpp') return 'cpp'
    if (language === 'c') return 'c'
    const ext = path.extname(filename || '').toLowerCase()
    if (['.cpp', '.cc', '.cxx', '.hpp', '.hh', '.hxx'].includes(ext)) return 'cpp'
    return 'c'
}

app.post('/api/analyze', async (req, res) => {
    const { source, filename, language } = req.body || {}
    if (!source || typeof source !== 'string') {
        return res.status(400).json({ error: 'Missing source code.' })
    }

    if (!existsSync(pluginPath)) {
        return res.status(400).json({
            error: 'LLVM pass plugin not found. Build the pass first in /pass/build.',
        })
    }

    const lang = inferLanguage(filename, language)
    const ext = lang === 'cpp' ? '.cpp' : '.c'

    let tempDir
    try {
        tempDir = await fs.mkdtemp(path.join(os.tmpdir(), 'wifa-'))
        const srcPath = path.join(tempDir, `input${ext}`)
        const irPath = path.join(tempDir, 'input.ll')
        const outDir = path.join(tempDir, 'output')
        await fs.mkdir(outDir)
        await fs.writeFile(srcPath, source, 'utf8')

        const clangArgs = lang === 'cpp'
            ? ['-x', 'c++', '-std=c++17', '-S', '-emit-llvm', '-O0', srcPath, '-o', irPath]
            : ['-x', 'c', '-S', '-emit-llvm', '-O0', srcPath, '-o', irPath]

        await runCommand('clang-17', clangArgs, { cwd: rootDir })
        await runCommand(
            'opt-17',
            ['--load-pass-plugin', pluginPath, '--passes=wifa', irPath, '-o', '/dev/null'],
            { cwd: rootDir, env: { ...process.env, WIFA_OUTPUT_DIR: outDir } }
        )

        const reportPath = path.join(outDir, 'analysis_report.json')
        const reportText = await fs.readFile(reportPath, 'utf8')
        const report = JSON.parse(reportText)

        return res.json({ report })
    } catch (err) {
        return res.status(500).json({ error: err.message || 'Analysis failed.' })
    } finally {
        if (tempDir) {
            await fs.rm(tempDir, { recursive: true, force: true })
        }
    }
})

app.post('/api/demangle', async (req, res) => {
    const { symbols } = req.body || {}
    if (!Array.isArray(symbols) || symbols.length === 0) {
        return res.status(400).json({ error: 'Missing symbols array.' })
    }

    try {
        const input = symbols.join('\n')
        const result = await new Promise((resolve, reject) => {
            const proc = execFile('c++filt', [], { maxBuffer: 1024 * 1024 }, (err, stdout, stderr) => {
                if (err) return reject(err)
                resolve(stdout)
            })
            proc.stdin.write(input)
            proc.stdin.end()
        })

        const demangled = result.trim().split('\n')
        const mapping = {}
        symbols.forEach((sym, i) => {
            mapping[sym] = demangled[i] || sym
        })
        return res.json({ mapping })
    } catch (err) {
        // If c++filt isn't available, return identity mapping
        const mapping = {}
        symbols.forEach(sym => { mapping[sym] = sym })
        return res.json({ mapping })
    }
})

app.listen(port, () => {
    console.log(`[WIFA] API server running on http://localhost:${port}`)
})
