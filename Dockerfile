FROM meshuaib/ionic-fastlane
WORKDIR /app
COPY . /app/
RUN cd /app/platforms/android
ENV LANG=en_US.UTF-8
RUN ls -lart && \
fastlane test
