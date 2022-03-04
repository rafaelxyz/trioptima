
FROM public.ecr.aws/docker/library/python:3.8
COPY requirements.txt /code/
COPY app.py /code/
WORKDIR /code
# Server reload on file change
ENV FLASK_ENV=development
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
CMD python app.py
