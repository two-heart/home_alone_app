FROM cirrusci/flutter:stable

RUN echo y | sdkmanager --licenses && \
echo y | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;28.0.3" && \
echo y | $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-28"