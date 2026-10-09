FROM python:3.12-slim

WORKDIR /app

COPY pyproject.toml README.rst LICENSE.txt ./
COPY flaskr ./flaskr


RUN python -m pip install -e .

EXPOSE 5000


CMD ["flask", "--app", "flaskr", "run", "--host=0.0.0.0", "--port=5000"]
