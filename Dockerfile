# Use a base image with Java and Tomcat pre-installed
FROM debian:latest AS build-env

RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 sed
RUN apt-get clean

RUN git init
RUN git config http.postBuffer 524288000
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"

RUN flutter doctor -v

RUN flutter upgrade
RUN flutter channel master
RUN flutter config --enable-web

RUN mkdir /app/
COPY /fe/ /app/
WORKDIR /app/
RUN flutter build web


EXPOSE 5000

FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html