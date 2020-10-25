FROM python:slim-buster as base

FROM base as builder

RUN mkdir /install
WORKDIR /install

COPY requirements.txt /requirements.txt

RUN pip install --prefix=/install -r /requirements.txt

FROM base

COPY --from=builder /install /usr/local/
COPY ./src /app/src/
COPY terminus_browser.py /app/

RUN groupadd -r app ;\
    useradd -r -g app -d /app -s /sbin/nologin -c "nevermind what im doing here" app ;\
    chown -R app /app

USER app
WORKDIR /app

CMD ["python","/app/terminus_browser.py"]
