# pull official base image
FROM python:3.12.4-slim-bookworm

# set working directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

#install system dependencies
RUN apt-get update \
    && apt-get -y install netcat-traditional gcc postgresql \
    && apt-get clean 

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

#copy entrypoint.sh
COPY ./entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# add app
COPY . .

#run entrypoint.sh on container startup
ENTRYPOINT [ "/usr/src/app/entrypoint.sh" ]