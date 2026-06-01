# WIFA Dashboard

React UI and Express API server for the WIFA LLVM analysis pass.

## Requirements

- Node.js 18+
- Built LLVM pass plugin at `pass/output/libWeightedFreqPass.so`
- LLVM 17 tools in PATH: `clang-17` and `opt-17`

## Development

From this directory:

```bash
npm install
npm run dev
```

This starts:

- UI: Vite dev server (default `http://localhost:5173`)
- API: Express server (default `http://localhost:3001`)

To change the API port, set `WIFA_PORT`:

```bash
WIFA_PORT=4001 npm run dev:api
```

## Production Build

```bash
npm run build
npm run preview
```

## API Notes

- `POST /api/analyze` accepts C/C++ source and returns a JSON report.
- The server runs the LLVM pass using `opt-17` and writes to a temp directory.
- If the plugin is missing, the API returns an error. Build it from the repo
	root using `./run.sh` or by following the root README.
