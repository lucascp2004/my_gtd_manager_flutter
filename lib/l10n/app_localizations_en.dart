// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get newItem => 'New Item';

  @override
  String get newFolder => 'New Folder';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get del => 'Delete';

  @override
  String get emptyName => 'Empty name';

  @override
  String get emptyError => 'This field should not be empty';

  @override
  String get myLists => 'My Lists';

  @override
  String get onlyFav => 'Only fav';

  @override
  String get showAll => 'Show all';

  @override
  String get listName => 'List name';

  @override
  String get newListName => 'New List name';

  @override
  String get projectName => 'Project name';

  @override
  String get newProjectName => 'New Project name';

  @override
  String get folderName => 'Folder name';

  @override
  String get newFolderName => 'New folder name';

  @override
  String get itemName => 'Item name';

  @override
  String get newItemName => 'New item name';

  @override
  String get taskPagetoolTip => 'New task';

  @override
  String get listPagetoolTip => 'New element';

  @override
  String get todoPagetoolTip => 'New item';

  @override
  String get listsPageTooltip => 'New list';

  @override
  String get newElementHint => 'Type a item or folder here';

  @override
  String get emailHint => 'Type your email here';

  @override
  String get passwordHint => 'Type your password here';

  @override
  String get logIn => 'Log in';

  @override
  String get ok => 'OK';

  @override
  String get signUp => 'Sign up';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get verifyEmail => 'Please verify your email to complete sign-up.';

  @override
  String get forgotPassword => 'Forgot password';

  @override
  String get emailRecovery => 'Password reset email sent. Please check your inbox.';

  @override
  String get googleSignInError => 'Error in Google Log in';

  @override
  String get signInError => 'Sign-in failed. Please try again later.';

  @override
  String get networkRequestFailed => 'No internet connection. Please try again later.';

  @override
  String get emailAlreadyInUse => 'Email address already in use. Please try a different email.';

  @override
  String get invalidEmail => 'Invalid email address. Please enter a valid email.';

  @override
  String get weakPassword => 'Password is too weak';

  @override
  String get signUpError => 'Sign-up failed. Please try again later.';

  @override
  String get googleSignUpError => 'Google sign-up failed. Please try again later.';

  @override
  String get wrongPassword => 'Incorrect password. Please try again.';

  @override
  String get january => 'Jan';

  @override
  String get february => 'Feb';

  @override
  String get march => 'Mar';

  @override
  String get april => 'Apr';

  @override
  String get may => 'May';

  @override
  String get june => 'Jun';

  @override
  String get july => 'Jul';

  @override
  String get august => 'Aug';

  @override
  String get september => 'Sep';

  @override
  String get october => 'Oct';

  @override
  String get november => 'Nov';

  @override
  String get december => 'Dec';

  @override
  String get monday => 'MON';

  @override
  String get tuesday => 'TUE';

  @override
  String get wednesday => 'WED';

  @override
  String get thursday => 'THU';

  @override
  String get friday => 'FRI';

  @override
  String get saturday => 'SAT';

  @override
  String get sunday => 'SUN';

  @override
  String get changeItem => 'Change Item';

  @override
  String get addTask => 'Add Task';

  @override
  String get changeTask => 'Change Task';

  @override
  String get deleteTask => 'Delete task';

  @override
  String get notes => 'Notes';

  @override
  String deleteConfirmation(String este_or_esta, String item) {
    return 'Are you sure you want to delete this $item?';
  }

  @override
  String get tutorial => 'Youtube tutorial';

  @override
  String get relatedTask => 'Create task...';

  @override
  String get relatedList => 'Copy to lists...';

  @override
  String get noTodoListError => 'There\'s no todo lists!';

  @override
  String get finishTask => 'Task completed';

  @override
  String get unfinishTask => 'Reopen Task';

  @override
  String get repeatEvery => 'Repeat every';

  @override
  String get item => 'item';

  @override
  String get folder => 'Folder';

  @override
  String get list => 'List';

  @override
  String get project => 'project';

  @override
  String get task => 'task';

  @override
  String get userDisabled => 'Your account is disabled. Please contact support.';

  @override
  String get userNotFound => 'User not found. Please check your email.';

  @override
  String get invalidCredenditals => 'Email or password is invalid.';

  @override
  String get sundayInOneLetter => 'S';

  @override
  String get mondayInOneLetter => 'M';

  @override
  String get tuesdayInOneLetter => 'T';

  @override
  String get wednesdayInOneLetter => 'W';

  @override
  String get thursdayInOneLetter => 'T';

  @override
  String get fridayInOneLetter => 'F';

  @override
  String get saturdayInOneLetter => 'S';

  @override
  String get day => 'day';

  @override
  String get week => 'week';

  @override
  String get month => 'month';

  @override
  String get year => 'year';

  @override
  String get dateTasK => 'Date task';

  @override
  String get repeat => 'Repeat?';

  @override
  String get noRepeat => 'No repeat';

  @override
  String get errStartAfterEnd => 'Start time after end time';

  @override
  String get startTime => 'Start Time';

  @override
  String get endTime => 'End Time';

  @override
  String get flexibleStartTime => 'Flexible start time';

  @override
  String get fixedStartTime => 'Fixed Start Time';

  @override
  String get emailError => 'Your email is not valid';

  @override
  String get passwordError => 'Your password must be at least 8 characters long.';

  @override
  String get appName => 'LifeFlow Organizer';

  @override
  String get validRepetitionError => 'Please, insert a valid repetition value';

  @override
  String get selectDayError => 'Please, select at least one day of the week for the task to repeat.';

  @override
  String get typeNameForTaskError => 'Please, type a name for the task';

  @override
  String get everDay => 'Every day';

  @override
  String get everWeek => 'Every week';

  @override
  String get everMonth => 'Every month';

  @override
  String get everYear => 'Every year';

  @override
  String get customRepeat => 'Custom repeat';

  @override
  String get chooseDate => 'Choose date';

  @override
  String get projects => 'Projects';

  @override
  String get chooseTime => 'Choose Time';

  @override
  String get logout => 'Logout';

  @override
  String get planner => 'Planner';

  @override
  String get todoList1 => 'Someday/maybe';

  @override
  String get todoList2 => 'Next Actions';

  @override
  String get todoList3 => 'Inbox';

  @override
  String get unselectAll => 'Unselect All';

  @override
  String get unselectAllQuestion => 'Do you want unselect all items?';

  @override
  String get todolists => 'Todo Lists';

  @override
  String get deleteTaskAndItems => 'Also delete associated task or todo items';

  @override
  String get deleteRelatedProject => 'Also delete associated project item';

  @override
  String get seeRelatedTask => 'See associated task';

  @override
  String get seeRelatedTodoItem => 'See associted Todo item';

  @override
  String get insertTodoItem => 'Insert an item...';

  @override
  String get emailRecoveryError => 'Password reset failed. Please try again later.';

  @override
  String get getBackupError => 'Error checking for online backup.';

  @override
  String get signUpMessage1 => 'We\'ve sent a verification link to your email. Please check your inbox.';

  @override
  String get signUpMessage2 => 'A verification email will be sent to you once you have logged in.';

  @override
  String get initMessage => 'Initialization...';

  @override
  String get saveButton => 'Save';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get reloadPage => 'Reload Page';

  @override
  String get loading => 'Loading...';

  @override
  String get signUpWithGoogle => 'Log in with Google';

  @override
  String get localDataError => 'Error retrieving data from local storage.';

  @override
  String get signUpPage => 'Sign up screen';

  @override
  String get signUpButton => 'Sign up';

  @override
  String get sendNewPassword => 'Send';

  @override
  String get auxiliaryItem => 'Inside of';

  @override
  String get dontDrag => 'Don\'t drag, it doesn\'t change anything';

  @override
  String get dragItem => 'Drag elements';

  @override
  String get close => 'Close';

  @override
  String get youtubeError => 'Could not launch';

  @override
  String get error => 'Error';

  @override
  String get changeFolder => 'Change Folder';

  @override
  String get changeItemName => 'Change Item name';

  @override
  String get changeFolderName => 'Change Folder name';

  @override
  String get moveItem => 'Move item';

  @override
  String get moveFolder => 'Move folder';

  @override
  String get deleteItem => 'Delete item';

  @override
  String get deleteFolder => 'Delete folder';

  @override
  String get noFolder => 'No folder';

  @override
  String get today => 'Today.';

  @override
  String get tomorrow => 'Tomorrow.';

  @override
  String get yesterday => 'Yesterday.';
}
