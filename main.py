"""Railway entry point - imports the FastAPI app from backend."""
import sys
import os
from pathlib import Path

# Add the current directory to Python path to ensure backend module can be imported
current_dir = Path(__file__).parent.absolute()
if str(current_dir) not in sys.path:
    sys.path.insert(0, str(current_dir))

# Ensure we can import backend
try:
    from backend.main import app
except ImportError as e:
    # If import fails, print helpful error
    print(f"Failed to import backend.main: {e}", file=sys.stderr)
    print(f"Current directory: {current_dir}", file=sys.stderr)
    print(f"Python path: {sys.path}", file=sys.stderr)
    print(f"Files in current dir: {list(current_dir.iterdir())}", file=sys.stderr)
    raise

# This allows Railway to run: uvicorn main:app
__all__ = ["app"]
