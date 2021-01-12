FROM meshuaib/ionic-fastlane
WORKDIR /app
COPY . /app/
RUN cd /app/platforms/android
RUN export LANG=en_US.UTF-8
RUN ls -lart && \
fastlane test
