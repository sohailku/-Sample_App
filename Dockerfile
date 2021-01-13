FROM meshuaib/ionic-fastlane
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales locales-all

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8



WORKDIR /app/platforms/android
COPY . /app/

RUN fastlane test

CMD ["bash"]
