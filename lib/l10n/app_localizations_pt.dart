// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get newItem => 'Novo Item';

  @override
  String get newFolder => 'Nova Pasta';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancel';

  @override
  String get del => 'Apagar';

  @override
  String get emptyName => 'Nome em branco';

  @override
  String get emptyError => 'Esse campo não deveria estar vazio';

  @override
  String get myLists => 'Minhas Listas';

  @override
  String get onlyFav => 'Favoritos';

  @override
  String get showAll => 'Concluídos';

  @override
  String get listName => 'Nome da lista';

  @override
  String get newListName => 'Novo nome da lista';

  @override
  String get projectName => 'Nome do projeto';

  @override
  String get newProjectName => 'Novo nome do projeto';

  @override
  String get folderName => 'Nome da pasta';

  @override
  String get newFolderName => 'Novo nome da pasta';

  @override
  String get itemName => 'Nome do item';

  @override
  String get newItemName => 'Novo nome do item';

  @override
  String get taskPagetoolTip => 'Nova tarefa';

  @override
  String get listPagetoolTip => 'Novo elemento';

  @override
  String get todoPagetoolTip => 'Novo item';

  @override
  String get listsPageTooltip => 'Nova lista';

  @override
  String get newElementHint => 'Digite um item ou pasta aqui';

  @override
  String get emailHint => 'Digite o seu email aqui';

  @override
  String get passwordHint => 'Digite sua senha aqui';

  @override
  String get logIn => 'Entrar';

  @override
  String get ok => 'OK';

  @override
  String get signUp => 'Cadastrar';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get verifyEmail => 'Por favor, verifique o seu email para completar o cadastro';

  @override
  String get forgotPassword => 'Esqueceu sua senha?';

  @override
  String get emailRecovery => 'Um email de recuperação de password foi enviado.';

  @override
  String get googleSignInError => 'Erro no login do Google.';

  @override
  String get signInError => 'Erro no login. Por favor, tente denovo.';

  @override
  String get networkRequestFailed => 'Sem conexão a internet. Por favor, tente mais tarde.';

  @override
  String get emailAlreadyInUse => 'Endereço de email já em uso. Por favor, tente um email diferente.';

  @override
  String get invalidEmail => 'Endereço de email inválido.';

  @override
  String get weakPassword => 'A senha é muito fraca.';

  @override
  String get signUpError => 'Falha no cadastro. Por favor, tente novamente mais tarde.';

  @override
  String get googleSignUpError => 'Falha no cadastro com o Google.';

  @override
  String get wrongPassword => 'Senha incorreta. Por favor, tente novamente.';

  @override
  String get january => 'Jan';

  @override
  String get february => 'Fev';

  @override
  String get march => 'Mar';

  @override
  String get april => 'Abr';

  @override
  String get may => 'Mai';

  @override
  String get june => 'Jun';

  @override
  String get july => 'Jul';

  @override
  String get august => 'Ago';

  @override
  String get september => 'Set';

  @override
  String get october => 'Out';

  @override
  String get november => 'Nov';

  @override
  String get december => 'Dez';

  @override
  String get monday => 'SEG';

  @override
  String get tuesday => 'TER';

  @override
  String get wednesday => 'QUA';

  @override
  String get thursday => 'QUI';

  @override
  String get friday => 'SEX';

  @override
  String get saturday => 'SAB';

  @override
  String get sunday => 'DOM';

  @override
  String get changeItem => 'Alterar item';

  @override
  String get addTask => 'Adicionar Tarefa';

  @override
  String get changeTask => 'Modificar Tarefa';

  @override
  String get deleteTask => 'Apagar tarefa';

  @override
  String get notes => 'Notas\n(opcional)';

  @override
  String deleteConfirmation(String este_or_esta, String item) {
    return 'Você tem certeza que deseja deletar $este_or_esta $item?';
  }

  @override
  String get tutorial => 'Tutorial no youtube';

  @override
  String get relatedTask => 'Criar tarefa...';

  @override
  String get relatedList => 'Copiar para listas...';

  @override
  String get noTodoListError => 'Não há lista de tarefas';

  @override
  String get finishTask => 'Tarefa concluída';

  @override
  String get unfinishTask => 'Reabrir a tarefa';

  @override
  String get repeatEvery => 'Repete a cada...';

  @override
  String get item => 'item';

  @override
  String get folder => 'Pasta';

  @override
  String get list => 'Lista';

  @override
  String get project => 'projeto';

  @override
  String get task => 'tarefa';

  @override
  String get userDisabled => 'Sua conta está desativada.';

  @override
  String get userNotFound => 'Usuário não encontrado. Por favor, verifique seu email.';

  @override
  String get invalidCredenditals => 'Email ou senha inválidos.';

  @override
  String get sundayInOneLetter => 'D';

  @override
  String get mondayInOneLetter => 'S';

  @override
  String get tuesdayInOneLetter => 'T';

  @override
  String get wednesdayInOneLetter => 'Q';

  @override
  String get thursdayInOneLetter => 'Q';

  @override
  String get fridayInOneLetter => 'S';

  @override
  String get saturdayInOneLetter => 'S';

  @override
  String get day => 'dia';

  @override
  String get week => 'semana';

  @override
  String get month => 'mês';

  @override
  String get year => 'ano';

  @override
  String get dateTasK => 'Data da tarefa';

  @override
  String get repeat => 'Repete?';

  @override
  String get noRepeat => 'Sem repetição';

  @override
  String get errStartAfterEnd => 'Erro: Início da tarefa após o fim';

  @override
  String get startTime => 'Início';

  @override
  String get endTime => 'Fim';

  @override
  String get flexibleStartTime => 'Sem horário de início';

  @override
  String get fixedStartTime => 'Com horário de início';

  @override
  String get emailError => 'Seu e-mail não é válido';

  @override
  String get passwordError => 'Sua senha deve ter no mínimo 8 caracteres';

  @override
  String get appName => 'Organize a sua vida';

  @override
  String get validRepetitionError => 'Por favor, insira um valor de repetição válido';

  @override
  String get selectDayError => 'Por favor, selecione pelo menos um dia da semana para a tarefa se repetir.';

  @override
  String get typeNameForTaskError => 'Por favor, digite um nome para a tarefa';

  @override
  String get everDay => 'Todo dia';

  @override
  String get everWeek => 'Toda semana';

  @override
  String get everMonth => 'Todo mês';

  @override
  String get everYear => 'Todo ano';

  @override
  String get customRepeat => 'Repetição personalizada';

  @override
  String get chooseDate => 'Escolha uma data';

  @override
  String get projects => 'Projetos';

  @override
  String get chooseTime => 'Escolha o horário';

  @override
  String get logout => 'Sair';

  @override
  String get planner => 'Agenda';

  @override
  String get todoList1 => 'Someday/maybe';

  @override
  String get todoList2 => 'Next Actions';

  @override
  String get todoList3 => 'Inbox';

  @override
  String get unselectAll => 'Desmarcar tudo';

  @override
  String get unselectAllQuestion => 'Você quer desmarcar todos os items?';

  @override
  String get todolists => 'Listas de tarefas';

  @override
  String get deleteTaskAndItems => 'Deletar também tarefa ou item associado';

  @override
  String get deleteRelatedProject => 'Deletar também item de projeto associado';

  @override
  String get seeRelatedTask => 'Ver tarefa associada';

  @override
  String get seeRelatedTodoItem => 'Ver item associado';

  @override
  String get insertTodoItem => 'Insira um item...';

  @override
  String get emailRecoveryError => 'Falha na redefinição de senha.';

  @override
  String get getBackupError => 'Erro ao verificar o backup online.';

  @override
  String get signUpMessage1 => 'Um e-mail de verificação será enviado para você. Por favor, verifique seu e-mail (incluindo a pasta de spam) e confirme sua conta.';

  @override
  String get signUpMessage2 => 'Um e-mail de verificação será enviado para você assim que você fizer o login.';

  @override
  String get initMessage => 'Iniciando...';

  @override
  String get saveButton => 'Salvar';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get reloadPage => 'Recarregar página';

  @override
  String get loading => 'Carregando...';

  @override
  String get signUpWithGoogle => 'Entrar com Google';

  @override
  String get localDataError => 'Erro acesando dados do celular.';

  @override
  String get signUpPage => 'Tela de cadastro';

  @override
  String get signUpButton => 'Cadastrar';

  @override
  String get sendNewPassword => 'Enviar';

  @override
  String get auxiliaryItem => 'Dentro de';

  @override
  String get dontDrag => 'Não arraste, não muda nada';

  @override
  String get dragItem => 'Arrastar elementos';

  @override
  String get close => 'Fechar';

  @override
  String get youtubeError => 'Não foi possível rodar o vídeo';

  @override
  String get error => 'Erro';

  @override
  String get changeFolder => 'Alterar pasta';

  @override
  String get changeItemName => 'Alterar o nome do item';

  @override
  String get changeFolderName => 'Alterar o nome da pasta';

  @override
  String get moveItem => 'Mover item';

  @override
  String get moveFolder => 'Mover pasta';

  @override
  String get deleteItem => 'Apagar item';

  @override
  String get deleteFolder => 'Apagar pasta';

  @override
  String get noFolder => 'Sem pasta';

  @override
  String get today => 'Hoje.';

  @override
  String get tomorrow => 'Amanhã.';

  @override
  String get yesterday => 'Ontem.';
}
