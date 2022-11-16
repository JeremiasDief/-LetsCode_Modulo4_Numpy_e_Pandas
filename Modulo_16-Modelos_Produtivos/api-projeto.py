from fastapi import FastAPI, Request, status, HTTPException
from pydantic import BaseModel
import requests
import mlflow
from fastapi.encoders import jsonable_encoder
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse, PlainTextResponse
from starlette.exceptions import HTTPException as StarletteHTTPException
import pandas as pd

# uvicorn api-projeto:app --reload --port 8001
# explorer.exe . >>> para ver a pasta onde estão os arquivos do linux

class GermanCredit(BaseModel):
    age: float
    sex: float
    job: float
    housing: float
    saving_accounts: float
    checking_account: float
    credit_amount: float
    duration: float
    purpose: float


app = FastAPI()

@app.get("/status")
def status() -> dict:
    return {"status":"on"}

@app.get("/experiments")
def get_experiments():
    url = "http://127.0.0.1:8000/api/2.0/preview/mlflow/experiments/list"
    response = requests.request("GET", url=url)
    dados = response.json()
    print("AQUI", dados)
    return dados


@app.post("/model")
def predict(german_credit: GermanCredit): 
    mlflow.set_tracking_uri(uri='http://127.0.0.1:8000/')
    PATH = 'models:/ModeloFinal_Projeto/Production'
    classes = ["bad", "good"]
    loaded_model = mlflow.sklearn.load_model(PATH)

    dados = [[f[1] for f in german_credit]]
    label = loaded_model.predict(pd.DataFrame(dados)) #list array [[], [], []]

    resultado = classes[int(label[0])]
    return {"class": resultado}