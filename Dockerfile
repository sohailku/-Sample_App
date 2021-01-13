FROM meshuaib/ionic-fastlane
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales locales-all

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8



USER root
COPY . /app/
WORKDIR /app/platforms/android
RUN  echo $pwd
RUN ls -la
RUN fastlane test

