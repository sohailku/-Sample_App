FROM meshuaib/ionic-fastlane
WORKDIR /app
COPY . /app/
RUN cd /app/android/
RUN ls -la