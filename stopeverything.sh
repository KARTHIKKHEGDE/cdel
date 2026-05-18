#!/usr/bin/env bash
set -euo pipefail

kill_port() {
  local port="$1"
  if command -v lsof >/dev/null 2>&1; then
    local pids
    pids=$(lsof -t -i ":${port}" 2>/dev/null || true)
    if [[ -n "$pids" ]]; then
      echo "Killing processes on port ${port}: ${pids}"
      kill -9 ${pids}
    fi
  else
    echo "lsof not found. Install lsof or kill the process manually."
    exit 1
  fi
}

# Ports used by the dashboard UI and API
kill_port 5173
kill_port 5174
kill_port 5175

# Also stop any leftover Node/Vite processes if still running
if command -v pkill >/dev/null 2>&1; then
  pkill -f "node server/index.js" 2>/dev/null || true
  pkill -f "vite" 2>/dev/null || true
fi

echo "Done."
