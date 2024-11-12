FROM alpine:3.14

WORKDIR /app

COPY ./build/app/outputs/flutter-apk/app-release.apk /app/Tunisair_Mobile_V2.apk

EXPOSE 8080 

RUN apk add --no-cache darkhttpd

CMD ["darkhttpd", "/app", "--port", "8080"]
