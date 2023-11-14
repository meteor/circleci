FROM circleci/android:api-30-node
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
ENV NODE_VERSION 14.21.3
ENV NVM_DIR ~/.nvm
SHELL ["/bin/bash", "-c"]

RUN wget -qO - https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

RUN sudo apt-get update && sudo apt-get install -y \
  gradle gconf-service libasound2 libatk1.0-0 libc6 libcairo2 \
  libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 \
  libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 \
  libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
  libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 \
  libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates \
  fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils \
  wget

USER root 

RUN . ~/.nvm/nvm.sh && source ~/.bashrc && nvm install $NODE_VERSION  \
  && nvm use $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && n=$(which node);n=${n%/bin/node}; sudo chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local

# Set Android environment variables
ENV ANDROID_HOME /opt/android/sdk
ENV ANDROID_VERSION 33

#RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "platforms;android-33"

# Download and install Android SDK
RUN wget -q https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip?hl=pt-br -O android-sdk.zip \
    && unzip -q android-sdk.zip -d $ANDROID_HOME \
    && rm android-sdk.zip

# Add Android tools and platform tools to the PATH
ENV PATH "$PATH:$ANDROID_HOME/cmdline-tools/bin:$ANDROID_HOME/platform-tools"

# Install required Android components
RUN yes | sdkmanager --licenses \
    && sdkmanager "build-tools;30.0.3" \
    && sdkmanager "platforms;android-33"

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*