FROM ubuntu:jammy

# utilities
RUN apt-get update && \
    apt-get -y install apt-transport-https unzip curl usbutils --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

# java
RUN apt-get update && \
    apt-get -y install software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get -y install openjdk-17-jdk-headless && \
    rm -r /var/lib/apt/lists/*
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64

# nodejs
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash - && \
    apt-get update && \
    apt-get -y install nodejs --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

# nativescript
RUN npm install -g nativescript@8.3.3 && \
    ns error-reporting disable && \
    ns usage-reporting disable

# android sdk
ENV ANDROID_HOME /opt/android-sdk
ENV PATH $PATH:$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/platform-tools
# link from https://developer.android.com/studio -> Command line tools only
ADD https://dl.google.com/android/repository/commandlinetools-linux-9123335_latest.zip /tmp/cmdtools.zip
RUN mkdir -p /opt/android-sdk/cmdline-tools && \
    unzip /tmp/cmdtools.zip && \
    rm /tmp/cmdtools.zip && \
    mv cmdline-tools/ /opt/android-sdk/cmdline-tools/tools
RUN echo "y" | sdkmanager "tools" "platform-tools" "platforms;android-32" \
    "build-tools;33.0.0"

# gradle & example project
WORKDIR /tmp
RUN ns create example --js
WORKDIR /tmp/example
RUN ns build android
RUN rm -rf /tmp/example

WORKDIR /app
