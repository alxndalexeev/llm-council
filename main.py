"""Railway entry point - imports the FastAPI app from backend."""
from backend.main import app

# This allows Railway to run: uvicorn main:app
__all__ = ["app"]
