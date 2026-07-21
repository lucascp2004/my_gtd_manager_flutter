sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa
sudo apt install openjdk-25-jdk openjdk-25-jre
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.44.6-stable.tar.xz
echo "export PATH=\"$PWD/flutter/bin:\$PATH\"" >> ~/.bashrc
source ~/.bashrc
wget https://edgedl.me.gvt1.com/android/studio/ide-zips/2026.1.2.10/android-studio-quail2-linux.tar.gz
tar -xvzf android-studio-quail2-linux.tar.gz
./android-studio/bin/studio.sh
 wget https://dl.google.com/android/repository/commandlinetools-linux-15859902_latest.zip
mkdir -p ~/Android/Sdk/cmdline-tools/latest
mv cmdline-tools/* ~/Android/Sdk/cmdline-tools/latest/
echo 'ANDROID_HOME="$HOME/Android/Sdk"' >> ~/.bashrc
echo 'ANDROID_SDK_ROOT="$ANDROID_HOME"' >> ~/.bashrc
echo 'PATH="$PATH:$ANDROID_HOME/platform-tools"' >> ~/.bashrc
echo 'PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"' >> ~/.bashrc
echo 'JAVA_HOME=/usr/lib/jvm/java-25-openjdk-amd64' >> ~/.bashrc
echo 'PATH="$JAVA_HOME/bin:$PATH"' >> ~/.bashrc

source ~/.bashrc
flutter doctor --android-licenses
flutter config --jdk-dir=/usr/lib/jvm/java-25-openjdk-amd64
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 24
npm install -g firebase-tools
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.bashrc
source ~/.bashrc
wget https://github.com/lucascp2004/my_gtd_manager_flutter/archive/refs/heads/main.zip
unzip main.zip
flutter create gtd_manager
rm -rf gtd_manager/lib/*
mv my_gtd_manager_flutter-main/lib/* gtd_manager/lib/
mv my_gtd_manager_flutter-main/integration-test/ gtd_manager/

cd gtd_manager
keytool -list -v \
-keystore ~/.android/debug.keystore \
-alias androiddebugkey \
-storepass android \
-keypass android
