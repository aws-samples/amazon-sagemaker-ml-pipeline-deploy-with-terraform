FROM python:3.7

# first layers should be dependency install so changes in code won't cause the build to
# start from scratch.
COPY requirements.txt /opt/program/requirements.txt

RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         nginx \
         ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir -r /opt/program/requirements.txt

# Set some environment variables. PYTHONUNBUFFERED keeps Python from buffering our standard
# output stream, which means that logs can be delivered to the user quickly. PYTHONDONTWRITEBYTECODE
# keeps Python from writing the .pyc files which are unnecessary in this case. We also update
# PATH so that the train and serve programs are found when the container is invoked.

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"
ENV MODEL_PATH="/opt/ml/model"

# Set up the program in the image
COPY algorithm_code /opt/program
WORKDIR /opt/program