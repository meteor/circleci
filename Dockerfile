FROM circleci/android:api-26-node8-alpha
RUN sudo apt-get update && sudo apt-get install gradle -y
