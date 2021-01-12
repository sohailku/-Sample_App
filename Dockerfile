FROM meshuaib/ionic-fastlane
WORKDIR /app
COPY . /app/
RUN export LANG=en_US.UTF-8
RUN cd /app/platforms/android && \
ls -lart && \
fastlane test
