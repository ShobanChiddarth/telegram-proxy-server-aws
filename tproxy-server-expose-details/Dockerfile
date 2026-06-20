FROM python:3.12 AS builder

COPY requirements.txt .

RUN pip install --no-cache-dir --target=/python -r requirements.txt


FROM python:3.12-slim AS runner

COPY --from=builder /python /python

ENV PYTHONPATH=/python

WORKDIR /app

COPY app.py .

RUN useradd -m runner
USER runner

EXPOSE 8000

CMD [ "python", "-m", "uvicorn", "app:app", "--host", "0.0.0.0", "--port",  "8000" ]
