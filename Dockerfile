FROM meshuaib/ionic-fastlane
WORKDIR /app
COPY . /app/
RUN cd /app/platforms/android
RUN ls -la
