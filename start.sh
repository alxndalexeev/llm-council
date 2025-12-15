#!/bin/bash

# LLM Council - Start script

echo "Starting LLM Council..."
echo ""

# Start backend (Railway expects the web process to bind to $PORT)
BACKEND_PORT="${PORT:-8001}"
echo "Starting backend on http://localhost:${BACKEND_PORT}..."
uv run uvicorn main:app --host 0.0.0.0 --port "${BACKEND_PORT}" &
BACKEND_PID=$!

# Wait a bit for backend to start
sleep 2

# Start frontend (local dev only). Railway's Python environment does not include npm/node.
FRONTEND_PID=""
if command -v npm >/dev/null 2>&1 && [ -z "${PORT:-}" ]; then
  echo "Starting frontend on http://localhost:5173..."
  cd frontend
  npm run dev &
  FRONTOEND_PID=$!
  cd ..
else
  echo "Skipping frontend start (npm not available or running in a hosted environment)."
fi

echo ""
echo "✓ LLM Council is running!"
echo "  Backend:  http://localhost:${BACKEND_PORT}"
if [ -n "${FRONTEND_PID}" ]; then
  echo "  Frontend: http://localhost:5173"
fi
echo ""
echo "Press Ctrl+C to stop both servers"

# Wait for Ctrl+C
trap "kill $BACKEND_PID ${FRONTEND_PID:-} 2>/dev/null; exit" SIGINT SIGTERM
wait
