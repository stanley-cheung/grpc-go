FROM golang:1.16

WORKDIR /grpc-go

COPY . .

RUN \
  apt-get update && \
  apt-get install -y emacs python3-pip && \
  apt-get clean

RUN pip3 install google-cloud-monitoring \
  google-cloud-trace \
  google-cloud-logging \
  google-auth

CMD ["/bin/sleep", "inf"]
