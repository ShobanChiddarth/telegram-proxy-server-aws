from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from urllib.request import urlopen

def get_public_ip() -> str:
    with urlopen("https://api.ipify.org?format=text") as response:
        return response.read().decode("utf-8")

def read_secret() -> str:
    with open("/data/secret") as fh:
        return fh.read().strip()

@asynccontextmanager
async def lifespan(app: FastAPI):
    app.state.public_ip = get_public_ip()
    app.state.port = 443
    app.state.secret = read_secret()
    yield

app = FastAPI(lifespan=lifespan)

@app.get("/")
@app.get("/{path:path}")
async def give_proxy_details(request: Request, path: str = ""):
    details = {
        "ip": request.app.state.public_ip,
        "port": request.app.state.port,
        "secret": request.app.state.secret
    }
    
    return details
