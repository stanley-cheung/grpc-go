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

WORKDIR /grpc-go/examples/helloworld

RUN go build greeter_server/main.go
RUN go build greeter_client/main.go

CMD ["/bin/sleep", "inf"]
