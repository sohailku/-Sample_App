FROM meshuaib/ionic-fastlane
WORKDIR /app/platforms/android
COPY . /app/
RUN export LANG=en_US.UTF-8
RUN cd /app/platforms/android && \
ls -lart
