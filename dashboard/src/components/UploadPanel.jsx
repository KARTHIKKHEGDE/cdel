import { useCallback, useMemo, useState } from 'react'
import { Upload } from 'lucide-react'
import useReportStore from '../store/useReportStore'
import { parseReport } from '../utils/parseReport'

export default function UploadPanel() {
    const loadReport = useReportStore(s => s.loadReport)
    const [sourceText, setSourceText] = useState('')
    const [fileName, setFileName] = useState('input.c')
    const [language, setLanguage] = useState('c')
    const [isRunning, setIsRunning] = useState(false)
    const [error, setError] = useState('')

    const formatError = useCallback((message) => {
        if (!message) return ''
        const normalized = message
            .replace(/\/tmp\/wifa-[^/]+\/input\.(c|cpp)/g, fileName || 'input')
            .replace(/\s+\|\s+/g, ' | ')
        return normalized.trim()
    }, [fileName])

    const samplePrograms = useMemo(() => ([
        {
            name: 'C sample - Loop + math',
            fileName: 'sample_loop.c',
            language: 'c',
            code: `#include <stdio.h>

int kernel(int n) {
    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += (i * 3) - (i / 2);
    }
    return sum;
}

int main(void) {
    printf("%d\\n", kernel(100));
    return 0;
}
`,
        },
        {
            name: 'C++ sample - Templates + recursion',
            fileName: 'sample_cpp.cpp',
            language: 'cpp',
            code: `#include <iostream>
#include <vector>

template <typename T>
T fib(int n) {
    if (n <= 1) return static_cast<T>(n);
    return fib<T>(n - 1) + fib<T>(n - 2);
}

int main() {
    std::vector<int> data(5);
    for (int i = 0; i < 5; i++) {
        data[i] = fib<int>(i + 4);
    }
    std::cout << data[2] << "\\n";
    return 0;
}
`,
        },
    ]), [])

    const handleFile = useCallback((file) => {
        if (!file) return
        const reader = new FileReader()
        reader.onload = (e) => {
            setSourceText(e.target.result)
            setFileName(file.name)
            const lower = file.name.toLowerCase()
            if (lower.endsWith('.cpp') || lower.endsWith('.cc') || lower.endsWith('.cxx')) {
                setLanguage('cpp')
            } else {
                setLanguage('c')
            }
        }
        reader.readAsText(file)
    }, [])

    const runAnalysis = useCallback(async () => {
        if (!sourceText.trim()) return
        setIsRunning(true)
        setError('')
        try {
            const res = await fetch('/api/analyze', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    source: sourceText,
                    filename: fileName,
                    language,
                }),
            })

            const contentType = res.headers.get('content-type') || ''
            const rawText = await res.text()
            const payload = contentType.includes('application/json')
                ? JSON.parse(rawText || '{}')
                : null

            if (!res.ok) {
                const msg = payload?.error || rawText || 'Analysis failed.'
                throw new Error(msg)
            }

            if (!payload?.report) {
                throw new Error('Missing report from backend.')
            }

            const report = parseReport(payload.report)
            loadReport(report, fileName || 'source')
        } catch (err) {
            if (err.message === 'Failed to fetch') {
                setError('Backend not reachable. Start it with: cd dashboard && npm run dev')
            } else {
                setError(formatError(err.message))
            }
        } finally {
            setIsRunning(false)
        }
    }, [sourceText, fileName, language, loadReport])

    const loadSample = useCallback((sample) => {
        setSourceText(sample.code)
        setFileName(sample.fileName)
        setLanguage(sample.language)
    }, [])

    const onDrop = (e) => {
        e.preventDefault()
        handleFile(e.dataTransfer.files[0])
    }

    return (
        <div className="space-y-6">
            <div
                onDrop={onDrop}
                onDragOver={e => e.preventDefault()}
                className="flex flex-col items-center justify-center gap-4 border-2 border-dashed border-border rounded-xl p-10 cursor-pointer hover:border-accent transition-colors"
                onClick={() => document.getElementById('file-input').click()}
            >
                <Upload size={40} className="text-muted" />
                <div className="text-center">
                    <p className="text-lg font-medium text-gray-200">
                        Drop a <code className="font-mono text-accent">.c</code> or <code className="font-mono text-accent">.cpp</code> file here
                    </p>
                    <p className="text-sm text-muted mt-1">
                        The backend runs the LLVM pass and returns the report
                    </p>
                </div>
                <input
                    id="file-input"
                    type="file"
                    accept=".c,.cpp,.cc,.cxx"
                    className="hidden"
                    onChange={e => handleFile(e.target.files[0])}
                />
            </div>

            <div className="bg-surface border border-border rounded-xl p-5">
                <p className="text-sm font-semibold text-muted uppercase tracking-widest mb-3">
                    Paste Source Code
                </p>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-3 mb-3">
                    <input
                        value={fileName}
                        onChange={e => setFileName(e.target.value)}
                        placeholder="filename.c"
                        className="bg-bg border border-border rounded-lg px-3 py-2 text-xs font-mono text-gray-200 focus:outline-none focus:border-accent"
                    />
                    <select
                        value={language}
                        onChange={e => setLanguage(e.target.value)}
                        className="bg-bg border border-border rounded-lg px-3 py-2 text-xs font-mono text-gray-200 focus:outline-none focus:border-accent"
                    >
                        <option value="c">C</option>
                        <option value="cpp">C++</option>
                    </select>
                    <button
                        onClick={runAnalysis}
                        disabled={isRunning || !sourceText.trim()}
                        className="text-xs text-white bg-accent/80 hover:bg-accent px-3 py-2 rounded-lg transition-colors disabled:opacity-60 disabled:cursor-not-allowed"
                    >
                        {isRunning ? 'Running analysis...' : 'Run analysis'}
                    </button>
                </div>
                <textarea
                    value={sourceText}
                    onChange={e => setSourceText(e.target.value)}
                    placeholder="Paste C/C++ source code here"
                    className="w-full h-48 bg-bg border border-border rounded-lg p-3 text-xs font-mono text-gray-200 focus:outline-none focus:border-accent"
                />
                {error && (
                    <pre className="text-xs text-hot mt-2 whitespace-pre-wrap font-mono">
                        {error}
                    </pre>
                )}
            </div>

            <div className="bg-surface border border-border rounded-xl p-5">
                <p className="text-sm font-semibold text-muted uppercase tracking-widest mb-3">
                    Try a sample program
                </p>
                <div className="flex flex-wrap gap-2">
                    {samplePrograms.map(sample => (
                        <button
                            key={sample.name}
                            onClick={() => loadSample(sample)}
                            className="text-xs text-muted border border-border px-3 py-1.5 rounded-lg hover:text-white hover:border-accent transition-colors"
                        >
                            {sample.name}
                        </button>
                    ))}
                </div>
            </div>
        </div>
    )
}
