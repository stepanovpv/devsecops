FROM python:3.9-slim

ENV APP_HOME /app
WORKDIR $APP_HOME

RUN apt-get update && apt-get install -y locales ca-certificates --no-install-recommends \
    && rm -rf /var/cache/apt/archives/*

RUN printf 'en_US.UTF-8 UTF-8\n' >> /etc/locale.gen && locale-gen

COPY ./app/requirements.txt .
RUN pip install --no-cache-dir  -r requirements.txt

COPY ./app $APP_HOME

EXPOSE 80
WORKDIR /app

ENV FLASK_APP=finenomore \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8

ENTRYPOINT [ "flask", "run", "--host=0.0.0.0", "--port=80" ]
