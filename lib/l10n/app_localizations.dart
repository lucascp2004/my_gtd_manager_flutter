import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @newItem.
  ///
  /// In en, this message translates to:
  /// **'New Item'**
  String get newItem;

  /// New Folder radiobutton
  ///
  /// In en, this message translates to:
  /// **'New Folder'**
  String get newFolder;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get del;

  /// Generic error message for a text field that can't be empty
  ///
  /// In en, this message translates to:
  /// **'Empty name'**
  String get emptyName;

  /// No description provided for @emptyError.
  ///
  /// In en, this message translates to:
  /// **'This field should not be empty'**
  String get emptyError;

  /// My Lists label
  ///
  /// In en, this message translates to:
  /// **'My Lists'**
  String get myLists;

  /// Only fav checkbutton
  ///
  /// In en, this message translates to:
  /// **'Only fav'**
  String get onlyFav;

  /// Show all checkbutton
  ///
  /// In en, this message translates to:
  /// **'Show all'**
  String get showAll;

  /// Project name label
  ///
  /// In en, this message translates to:
  /// **'List name'**
  String get listName;

  /// New List name label
  ///
  /// In en, this message translates to:
  /// **'New List name'**
  String get newListName;

  /// No description provided for @projectName.
  ///
  /// In en, this message translates to:
  /// **'Project name'**
  String get projectName;

  /// New Project name label
  ///
  /// In en, this message translates to:
  /// **'New Project name'**
  String get newProjectName;

  /// Folder name label
  ///
  /// In en, this message translates to:
  /// **'Folder name'**
  String get folderName;

  /// New folder name label
  ///
  /// In en, this message translates to:
  /// **'New folder name'**
  String get newFolderName;

  /// Item name label
  ///
  /// In en, this message translates to:
  /// **'Item name'**
  String get itemName;

  /// New item name label
  ///
  /// In en, this message translates to:
  /// **'New item name'**
  String get newItemName;

  /// tooltip for a floating button that create a new task
  ///
  /// In en, this message translates to:
  /// **'New task'**
  String get taskPagetoolTip;

  /// tooltip for a floating button that create a new element in a project
  ///
  /// In en, this message translates to:
  /// **'New element'**
  String get listPagetoolTip;

  /// tooltip for a floating button that create a new element in a project
  ///
  /// In en, this message translates to:
  /// **'New item'**
  String get todoPagetoolTip;

  /// No description provided for @listsPageTooltip.
  ///
  /// In en, this message translates to:
  /// **'New list'**
  String get listsPageTooltip;

  /// hint to insert a new Element
  ///
  /// In en, this message translates to:
  /// **'Type a item or folder here'**
  String get newElementHint;

  /// hint to insert a new email
  ///
  /// In en, this message translates to:
  /// **'Type your email here'**
  String get emailHint;

  /// hint to insert a new password
  ///
  /// In en, this message translates to:
  /// **'Type your password here'**
  String get passwordHint;

  /// Log in button
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Sign up button
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// Label for the email input field in a sign-up or login form.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Label for the password input field in a sign-up or login form.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// This error message indicates that you need to verify your email address to complete the sign-up process
  ///
  /// In en, this message translates to:
  /// **'Please verify your email to complete sign-up.'**
  String get verifyEmail;

  /// Clicking the 'Forgot Password' button will open a dialog box where you can enter the email address associated with your account. We will send a password reset link to that email, which you can use to create a new password and regain access to your account.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPassword;

  /// This message indicates that a password reset email has been sent to the email address you provided. Please check your inbox for the email and follow the instructions to reset your password. If you do not see the email in your inbox, please check your spam or junk folder.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent. Please check your inbox.'**
  String get emailRecovery;

  /// Error message in google log in
  ///
  /// In en, this message translates to:
  /// **'Error in Google Log in'**
  String get googleSignInError;

  /// This error message indicates that there was a problem with the sign-in process, but the specific cause of the error is unknown
  ///
  /// In en, this message translates to:
  /// **'Sign-in failed. Please try again later.'**
  String get signInError;

  /// This error message is displayed when the user attempts to sign in, but the sign-in process fails due to a lack of internet connection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please try again later.'**
  String get networkRequestFailed;

  /// Error message displayed when a user attempts to sign up with an email address that is already associated with an existing account.
  ///
  /// In en, this message translates to:
  /// **'Email address already in use. Please try a different email.'**
  String get emailAlreadyInUse;

  /// Error message displayed when a user attempts to sign up or recover Password, or sing in with an invalid email address.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address. Please enter a valid email.'**
  String get invalidEmail;

  /// Error message displayed when a user attempts to sign up with a weak password.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak'**
  String get weakPassword;

  /// Error message displayed when a generic sign-up error occurs.
  ///
  /// In en, this message translates to:
  /// **'Sign-up failed. Please try again later.'**
  String get signUpError;

  /// Error message displayed when an error occurs during Google sign-up.
  ///
  /// In en, this message translates to:
  /// **'Google sign-up failed. Please try again later.'**
  String get googleSignUpError;

  /// Error message displayed when a user enters an incorrect password during login.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password. Please try again.'**
  String get wrongPassword;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get december;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'MON'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'TUE'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'WED'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'THU'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'FRI'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'SAT'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'SUN'**
  String get sunday;

  /// Title of a Alert dialog to change a item
  ///
  /// In en, this message translates to:
  /// **'Change Item'**
  String get changeItem;

  /// Window Label for a dialog to add a new Task
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTask;

  /// Window Label for a dialog to change a Task
  ///
  /// In en, this message translates to:
  /// **'Change Task'**
  String get changeTask;

  ///  Label for a button to delete a  Task
  ///
  /// In en, this message translates to:
  /// **'Delete task'**
  String get deleteTask;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// A confirmation message for deleting an item.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this {item}?'**
  String deleteConfirmation(String este_or_esta, String item);

  /// A link for a youtube tutorial
  ///
  /// In en, this message translates to:
  /// **'Youtube tutorial'**
  String get tutorial;

  /// No description provided for @relatedTask.
  ///
  /// In en, this message translates to:
  /// **'Create task...'**
  String get relatedTask;

  /// No description provided for @relatedList.
  ///
  /// In en, this message translates to:
  /// **'Copy to lists...'**
  String get relatedList;

  /// No description provided for @noTodoListError.
  ///
  /// In en, this message translates to:
  /// **'There\'s no todo lists!'**
  String get noTodoListError;

  /// A label for a button to mark a task as complete
  ///
  /// In en, this message translates to:
  /// **'Task completed'**
  String get finishTask;

  /// A label for a button to mark a completed task as uncompleted
  ///
  /// In en, this message translates to:
  /// **'Reopen Task'**
  String get unfinishTask;

  /// Label for a dropdown Menu to choose what kind the repetition the task has
  ///
  /// In en, this message translates to:
  /// **'Repeat every'**
  String get repeatEvery;

  /// List label
  ///
  /// In en, this message translates to:
  /// **'item'**
  String get item;

  /// Folder label
  ///
  /// In en, this message translates to:
  /// **'Folder'**
  String get folder;

  /// Helper for another phrase
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get list;

  /// Helper for another phrase
  ///
  /// In en, this message translates to:
  /// **'project'**
  String get project;

  /// Helper for another phrase
  ///
  /// In en, this message translates to:
  /// **'task'**
  String get task;

  /// Error message displayed when a user's account is disabled during login.
  ///
  /// In en, this message translates to:
  /// **'Your account is disabled. Please contact support.'**
  String get userDisabled;

  /// Error message displayed when a user is not found during login or password reset.
  ///
  /// In en, this message translates to:
  /// **'User not found. Please check your email.'**
  String get userNotFound;

  /// Erron on sign in
  ///
  /// In en, this message translates to:
  /// **'Email or password is invalid.'**
  String get invalidCredenditals;

  /// Sunday in one letter
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get sundayInOneLetter;

  /// Monday in one letter
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get mondayInOneLetter;

  /// Tuesday in one letter
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get tuesdayInOneLetter;

  /// Wednesday in one letter
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get wednesdayInOneLetter;

  /// Thursday in one letter
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get thursdayInOneLetter;

  /// Friday in one letter
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get fridayInOneLetter;

  /// Saturday in one letter
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get saturdayInOneLetter;

  /// one type of repetition for a task
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get day;

  /// one type of repetition for a task
  ///
  /// In en, this message translates to:
  /// **'week'**
  String get week;

  /// one type of repetition for a task
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get month;

  /// one type of repetition for a task
  ///
  /// In en, this message translates to:
  /// **'year'**
  String get year;

  /// label asking the first day of a task
  ///
  /// In en, this message translates to:
  /// **'Date task'**
  String get dateTasK;

  /// Label asking if the task has repetition
  ///
  /// In en, this message translates to:
  /// **'Repeat?'**
  String get repeat;

  /// Label for a task with no repetition
  ///
  /// In en, this message translates to:
  /// **'No repeat'**
  String get noRepeat;

  /// Error when start time is later than end time
  ///
  /// In en, this message translates to:
  /// **'Start time after end time'**
  String get errStartAfterEnd;

  /// Label for indicating the starting time of a task
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// Label for indicating the ending time of a task
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// Label for indicating a start time that can be adjusted or is not fixed
  ///
  /// In en, this message translates to:
  /// **'Flexible start time'**
  String get flexibleStartTime;

  /// Label for indicating a start time that is set and cannot be changed
  ///
  /// In en, this message translates to:
  /// **'Fixed Start Time'**
  String get fixedStartTime;

  /// Error message displayed on TextField when the entered email is not valid
  ///
  /// In en, this message translates to:
  /// **'Your email is not valid'**
  String get emailError;

  /// Error message displayed when the entered password is less than 8 characters
  ///
  /// In en, this message translates to:
  /// **'Your password must be at least 8 characters long.'**
  String get passwordError;

  /// App name
  ///
  /// In en, this message translates to:
  /// **'LifeFlow Organizer'**
  String get appName;

  /// Error message displayed when an invalid repetition value is entered
  ///
  /// In en, this message translates to:
  /// **'Please, insert a valid repetition value'**
  String get validRepetitionError;

  /// Error message displayed when no day of the week is selected for task repetition
  ///
  /// In en, this message translates to:
  /// **'Please, select at least one day of the week for the task to repeat.'**
  String get selectDayError;

  /// Error message displayed when the user has not entered a name for the task
  ///
  /// In en, this message translates to:
  /// **'Please, type a name for the task'**
  String get typeNameForTaskError;

  /// one type of repetition for a task
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get everDay;

  /// one type of repetition for a task
  ///
  /// In en, this message translates to:
  /// **'Every week'**
  String get everWeek;

  /// one type of repetition for a task
  ///
  /// In en, this message translates to:
  /// **'Every month'**
  String get everMonth;

  /// one type of repetition for a task
  ///
  /// In en, this message translates to:
  /// **'Every year'**
  String get everYear;

  /// one type of repetition for a task
  ///
  /// In en, this message translates to:
  /// **'Custom repeat'**
  String get customRepeat;

  /// Label to choose a date in the planner
  ///
  /// In en, this message translates to:
  /// **'Choose date'**
  String get chooseDate;

  /// Label for the logout button
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// Label for choose end time task
  ///
  /// In en, this message translates to:
  /// **'Choose Time'**
  String get chooseTime;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Label for one app screen
  ///
  /// In en, this message translates to:
  /// **'Planner'**
  String get planner;

  /// No description provided for @todoList1.
  ///
  /// In en, this message translates to:
  /// **'Someday/maybe'**
  String get todoList1;

  /// No description provided for @todoList2.
  ///
  /// In en, this message translates to:
  /// **'Next Actions'**
  String get todoList2;

  /// No description provided for @todoList3.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get todoList3;

  /// No description provided for @unselectAll.
  ///
  /// In en, this message translates to:
  /// **'Unselect All'**
  String get unselectAll;

  /// No description provided for @unselectAllQuestion.
  ///
  /// In en, this message translates to:
  /// **'Do you want unselect all items?'**
  String get unselectAllQuestion;

  /// Label for one app screen
  ///
  /// In en, this message translates to:
  /// **'Todo Lists'**
  String get todolists;

  /// No description provided for @deleteTaskAndItems.
  ///
  /// In en, this message translates to:
  /// **'Also delete associated task or todo items'**
  String get deleteTaskAndItems;

  /// No description provided for @deleteRelatedProject.
  ///
  /// In en, this message translates to:
  /// **'Also delete associated project item'**
  String get deleteRelatedProject;

  /// No description provided for @seeRelatedTask.
  ///
  /// In en, this message translates to:
  /// **'See associated task'**
  String get seeRelatedTask;

  /// No description provided for @seeRelatedTodoItem.
  ///
  /// In en, this message translates to:
  /// **'See associted Todo item'**
  String get seeRelatedTodoItem;

  /// TextField text do say to user insert a item
  ///
  /// In en, this message translates to:
  /// **'Insert an item...'**
  String get insertTodoItem;

  /// Error message displayed when a generic error occurs while attempting to reset a password.
  ///
  /// In en, this message translates to:
  /// **'Password reset failed. Please try again later.'**
  String get emailRecoveryError;

  /// Error message displayed when there's an issue while checking for online backup.
  ///
  /// In en, this message translates to:
  /// **'Error checking for online backup.'**
  String get getBackupError;

  /// Message displayed after the user signs up, informing them that a verification link has been sent to their email.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a verification link to your email. Please check your inbox.'**
  String get signUpMessage1;

  /// Message displayed after sign-up indicating that a verification email will be sent once the user has logged in.
  ///
  /// In en, this message translates to:
  /// **'A verification email will be sent to you once you have logged in.'**
  String get signUpMessage2;

  /// Message displayed during app initialization
  ///
  /// In en, this message translates to:
  /// **'Initialization...'**
  String get initMessage;

  /// Label for a button that saves changes
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// Label for a button that cancels changes or closes a dialog
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// Label for button to reload the current page.
  ///
  /// In en, this message translates to:
  /// **'Reload Page'**
  String get reloadPage;

  /// Message displayed to indicate that the app is loading or processing data.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Label for button to sign up using a Google account.
  ///
  /// In en, this message translates to:
  /// **'Log in with Google'**
  String get signUpWithGoogle;

  /// Error message displayed when there's an issue retrieving data from the local storage.
  ///
  /// In en, this message translates to:
  /// **'Error retrieving data from local storage.'**
  String get localDataError;

  /// Button to go for current page
  ///
  /// In en, this message translates to:
  /// **'Sign up screen'**
  String get signUpPage;

  /// Button to sign up
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUpButton;

  /// A button to send new Password
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendNewPassword;

  /// Empty space for drag and drop items
  ///
  /// In en, this message translates to:
  /// **'Inside of'**
  String get auxiliaryItem;

  /// Empty space for drag and drop items
  ///
  /// In en, this message translates to:
  /// **'Don\'t drag, it doesn\'t change anything'**
  String get dontDrag;

  /// Checkbox to choose if list elements are draggable
  ///
  /// In en, this message translates to:
  /// **'Drag elements'**
  String get dragItem;

  /// close label
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Error message
  ///
  /// In en, this message translates to:
  /// **'Could not launch'**
  String get youtubeError;

  /// Error label
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Title of a Alert dialog to change a folder
  ///
  /// In en, this message translates to:
  /// **'Change Folder'**
  String get changeFolder;

  /// Label for a button to change item name
  ///
  /// In en, this message translates to:
  /// **'Change Item name'**
  String get changeItemName;

  /// Label for a button to change folder name
  ///
  /// In en, this message translates to:
  /// **'Change Folder name'**
  String get changeFolderName;

  /// Label for a button to move a item
  ///
  /// In en, this message translates to:
  /// **'Move item'**
  String get moveItem;

  /// Label for a button to move a folder
  ///
  /// In en, this message translates to:
  /// **'Move folder'**
  String get moveFolder;

  /// Label for a button to delet a item
  ///
  /// In en, this message translates to:
  /// **'Delete item'**
  String get deleteItem;

  /// Label for a button to delet a folder
  ///
  /// In en, this message translates to:
  /// **'Delete folder'**
  String get deleteFolder;

  /// A text to indicate that a element it's not in a folder
  ///
  /// In en, this message translates to:
  /// **'No folder'**
  String get noFolder;

  /// greeting label to show the day
  ///
  /// In en, this message translates to:
  /// **'Today.'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow.'**
  String get tomorrow;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday.'**
  String get yesterday;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
