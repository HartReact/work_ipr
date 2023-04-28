FROM golang:1.20.3-alpine3.17

ENV DB_HOST=library-postgres \
    DB_DRIVER=postgres \
    DB_USER=root \
    DB_PASSWORD=root \
    DB_NAME=library \
    DB_PORT=5432 \
    APP_NAME=ipr

# Copy the source from the current directory to the working Directory inside the container
COPY ./app ${APP_NAME}/app

# Move to working directory
WORKDIR ${APP_NAME}/app/cmd

#install depedencies
RUN go mod tidy
RUN go mod download

# Build the application
RUN go build -o ./cmd
EXPOSE 8080
CMD [ "./cmd" ]