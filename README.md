# my_gtd_manager_flutter
Esse projeto é pra quem quer usar um gerenciador de gtd sem ter que pagar pelo backup. Eu poderia só publicar o aplicativo na Play Store, mas teria que cobrar mensalidade pelo backup, o que não é de graça. Pode um tutorial meio longo, mas vale a pena.

O primeiro passo é instalar o Flutter como é ensinado aqui https://docs.flutter.dev/install/manual

Depois crie o seu projeto flutter com flutter create project_name, isso criará a pasta dos projetos com muitos arquivos

Agora entre na pasta no projeto delete o conteudo da pasta lib. e delete o arquivo da pasta principal pubspec.yaml.

Baixe o projeto como zip, descompacte-o, se você não vai contribuir para o projeto pode deletar a pasta integration_test.

Copie o conteudo da pasta lib extraida do zip para a pasta lib do projeto e copie o pubspec.yaml para a pasta principal do projeto.

Agora vamos começar a configurar o backup, acesse https://console.firebase.google.com/?hl=pt-br&fb_gclid=CjwKCAjwpefSBhBvEiwAzyEtZxulN7COt5TH5oXUajpEg354I4cAKAlsVd2QaYqtyYQSoBNGv-OT8xoCVWwQAvD_BwE&fb_utm_campaign=Cloud-SS-DR-Firebase-FY26-global-pmax-1713590&fb_utm_content=pmax&fb_utm_medium=display&fb_utm_source=PMAX e crie um novo projeto

Para connectar o projeto criado no começo ao projeto Firebase precisamos do flutterfire, e para instalar o flutter fire precisamos do npm no Linux os passos são esses

1-
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
2-
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
3- 
source ~/.bashrc
4-para verificar se tudo deu certo até agora. 
nvm -v
5-
nvm install 24
6-para ver se tudo deu certo
node -v
npm -v

Para instalar o FlutterFire faça
npm install -g firebase-tools
dart pub global activate flutterfire_cli

Continua...






