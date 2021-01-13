FROM meshuaib/ionic-fastlane
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

WORKDIR /app/platforms/android
COPY . /app/
RUN export LANG=en_US.UTF-8
RUN cd /app/platforms/android && \
fastlane test
ls -lart
CMD ["bash"]
