FROM cimg/android:2023.03.1-node
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
ENV NODE_VERSION 14.21.3
ENV NVM_DIR ~/.nvm/


RUN sudo apt-get update && sudo apt-get install -y \
  openjdk-11-jdk gconf-service libasound2 libatk1.0-0 libc6 libcairo2 \
  libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 \
  libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 \
  libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
  libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 \
  libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates \
  fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils libgbm-dev \
  wget

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV JDK_HOME=${JAVA_HOME}
ENV JRE_HOME=${JDK_HOME}

# Updating default java version to be used
RUN sudo update-alternatives --set java /usr/lib/jvm/java-11-openjdk-amd64/bin/java

# Installing gradle
RUN curl -s "https://get.sdkman.io" | bash && \
    source "/home/circleci/.sdkman/bin/sdkman-init.sh" && \
    sdk install gradle 7.4.2

RUN . ~/.nvm/nvm.sh && source ~/.bashrc && nvm install $NODE_VERSION  \
  && nvm use $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local; rm -rf /home/circleci/project/*