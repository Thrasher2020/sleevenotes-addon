# SleeveNotes Home Assistant add-on.
#
# SleeveNotes is a single-page vinyl collection tracker (FastAPI + SQLite).
# Pure Python, no database server, so this is a single uvicorn process.
#
# Data is stored under /data (the add-on's persistent volume): the SQLite
# database at /data/sleevenotes.db and cached cover art at /data/images/.

ARG SLEEVENOTES_VERSION=1.11.0

FROM python:3.12-slim

ARG SLEEVENOTES_VERSION

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
        fastapi "uvicorn[standard]" httpx python-multipart pillow

RUN curl -fsSL "https://github.com/SiDtheTurtle/SleeveNotes/archive/refs/tags/v${SLEEVENOTES_VERSION}.tar.gz" \
    | tar -xz --strip-components=1 -C /app

EXPOSE 2026

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "2026"]
