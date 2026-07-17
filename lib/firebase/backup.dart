import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:my_gtd_manager_2/auth/auth_service.dart';
import 'package:my_gtd_manager_2/controllers/dates_function.dart';
import 'package:my_gtd_manager_2/database/database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_gtd_manager_2/helpers.dart';

//import 'package:connectivity_plus/connectivity_plus.dart';
class CustomTimer {
  late DateTime _finishTime;
  late Timer _timer;
  bool _hasExecuted = false;

  CustomTimer(int minutes) {
    _finishTime = DateTime.now().add(Duration(minutes: minutes));
    _timer = Timer(Duration(minutes: minutes), () {
      _executeCallback();
    });
  }

  void _executeCallback() {
    Backup.tryBackup();
    _hasExecuted = true;
  }

  bool get hasExecuted => _hasExecuted;
  DateTime get finishTime => _finishTime;

  void cancel() {
    _timer.cancel();
  }
}

class TimerList {
  final List<CustomTimer> _timers = [];
  TimerList();
  addTimer() {
    var foundSimilar = false;

    for (int i = _timers.length - 1; i >= 0; i--) {
      var timer = _timers[i];
      if (timer.hasExecuted) {
        _timers.remove(timer);
      } else {
        var diference = DateTime.now().difference(timer.finishTime).inMinutes;
        if (diference < 5) {
          _timers.remove(timer);
        } else {
          foundSimilar = true;
        }
      }
    }
    if (!foundSimilar) _timers.add(CustomTimer(15));
  }

  void cancelAll() {
    for (var timer in _timers) {
      timer.cancel();
    }
    _timers.clear();
  }
}

class Backup {
  static final TimerList _timers = TimerList();
  static int cont = 0;
  static int requests = 0;
  static bool _backupRunning = false;
  static bool _anotherBackupNeed = false;

  static String getUserPath() {
    final uid = AuthService.getUser()!.uid;

    return "/users/$uid";
  }

  static String getListsPath() {
    return "${getUserPath()}/backup/lists";
  }

  static String getBackupFlagPath() {
    return "${getUserPath()}/backup/backupFlag";
  }

  static String getElementsPath() {
    return "${getUserPath()}/backup/elements";
  }

  static String getTodoItemsPath() {
    return "${getUserPath()}/backup/todoitems";
  }

  static String getTasksPath() {
    return "${getUserPath()}/backup/tasks";
  }

  static String getMaxIdsPath() {
    return "${getUserPath()}/backup/maxIds";
  }

  static String getBackupFlagTempPath() {
    return "${getUserPath()}/temp/backupFlag";
  }

  static String getElementsTempPath() {
    return "${getUserPath()}/temp/elements";
  }

  static String getTodoItemsTempPath() {
    return "${getUserPath()}/temp/todoitems";
  }

  static String getTasksTempPath() {
    return "${getUserPath()}/temp/tasks";
  }

  static String getMaxIdsTempPath() {
    return "${getUserPath()}/temp/maxIds";
  }

  static String getSublistsTempPath() {
    return "${getUserPath()}/temp/sublists";
  }

  static String getSublistsPath() {
    return "${getUserPath()}/backup/sublists";
  }

  static String getListsTempPath() {
    return "${getUserPath()}/temp/lists";
  }

  static Future<void> setBackupNeeded(bool value) async {
    DatabaseDao.setBackupNeed(value);
  }

  /*Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }*/

  static DatabaseReference getBaseRef() {
    final dbReference = FirebaseDatabase.instance.ref(getUserPath());
    return dbReference;
  }

  static DatabaseReference getTempBackupRef() {
    final dbReference = FirebaseDatabase.instance.ref("${getUserPath()}/temp");
    return dbReference;
  }

  static DatabaseReference getBackupRef() {
    final dbReference = FirebaseDatabase.instance.ref(
      "${getUserPath()}/backup",
    );
    return dbReference;
  }

  static DatabaseReference getElementsRef() {
    final dbReference = FirebaseDatabase.instance.ref().child(
      getElementsPath(),
    );
    return dbReference;
  }

  static DatabaseReference getTodoItemsRef() {
    return FirebaseDatabase.instance.ref().child(getTodoItemsPath());
  }

  static DatabaseReference getTasksRef() {
    return FirebaseDatabase.instance.ref().child(getTasksPath());
  }

  static DatabaseReference getSettingsRef() {
    return FirebaseDatabase.instance.ref().child(getMaxIdsPath());
  }

  static DatabaseReference getElementsTempRef() {
    final dbReference = FirebaseDatabase.instance.ref().child(
      getElementsTempPath(),
    );
    return dbReference;
  }

  static DatabaseReference getTodoItemsTempRef() {
    final dbReference = FirebaseDatabase.instance.ref().child(
      getTodoItemsTempPath(),
    );
    return dbReference;
  }

  static DatabaseReference getTasksTempRef() {
    final dbReference = FirebaseDatabase.instance.ref().child(
      getTasksTempPath(),
    );
    return dbReference;
  }

  static DatabaseReference getSettingsTempRef() {
    final dbReference = FirebaseDatabase.instance.ref().child(
      getMaxIdsTempPath(),
    );
    return dbReference;
  }

  static DatabaseReference getSublistsTempRef() {
    final dbReference = FirebaseDatabase.instance.ref().child(
      getSublistsTempPath(),
    );
    return dbReference;
  }

  static DatabaseReference getSublistsRef() {
    final dbReference = FirebaseDatabase.instance.ref().child(
      getSublistsPath(),
    );
    return dbReference;
  }

  static DatabaseReference getBackupFlagTempRef() {
    final dbReference = FirebaseDatabase.instance.ref().child(
      getBackupFlagTempPath(),
    );
    return dbReference;
  }

  static DatabaseReference getBackupFlagRef() {
    final dbReference = FirebaseDatabase.instance.ref().child(
      getBackupFlagPath(),
    );
    return dbReference;
  }

  static DatabaseReference getTempListsRef() {
    final dbReference = FirebaseDatabase.instance.ref().child(
      getListsTempPath(),
    );
    return dbReference;
  }

  static DatabaseReference getListsRef() {
    final dbReference = FirebaseDatabase.instance.ref().child(getListsPath());
    return dbReference;
  }

  static DatabaseReference getMaxIdsRef() {
    final dbReference = FirebaseDatabase.instance.ref().child(getMaxIdsPath());
    return dbReference;
  }

  static Future<int> checkOnlineBackup() async {
    //this function is called with a user signed up
    //ohterwise need be changed.
    //1 has no backup
    //2 has backup
    //3 error checking backupUp (very unlikely)
    debugPrint("Checar se tem referência no db");

    try {
      debugPrint('vai tentar ver se tem backup');
      final data = await getBackupFlagRef().get();
      myPrint('tentou ver se tem backup');
      if (data.exists) {
        myPrint("já tem algo no backup");
        return 2;
      } else {
        myPrint("Db sem backup");

        return 1;
      }
    } catch (error) {
      myPrint("Deu ruim checkando db");
      return 3;
    }
  }

  static bool makeBackup(
    DateTime lastBackup,
    DateTime lastModified,
    DateTime timeBackup,
  ) {
    return lastModified.isAfter(lastBackup) &&
        lastModified.isBefore(timeBackup);
  }

  static Future<bool> backup() async {
    var signedUp = await AuthService.hasCredential();

    if (!signedUp) {
      return false;
    }
    var timeBackup = DateTime.now();
    DatabaseReference tempRef = getTempBackupRef();
    await tempRef.set({});

    final DatabaseReference listsTempRef,
        elementsTempRef,
        sublistsTempRef,
        todoitemsTempRef,
        tasksTempRef,
        maxIdsTempRef;

    listsTempRef = getTempListsRef();
    elementsTempRef = getElementsTempRef();
    sublistsTempRef = getSublistsTempRef();
    todoitemsTempRef = getTodoItemsTempRef();
    tasksTempRef = getTasksTempRef();
    maxIdsTempRef = getSettingsTempRef();

    var backupFlag = getBackupFlagTempRef();
    await backupFlag.set(true);
    var lists = await DatabaseDao.getAllLists();
    var sublists = await DatabaseDao.getAllSublists();
    var elements = await DatabaseDao.getAllItems();
    var todoElements = await DatabaseDao.getAllTodoItems();
    var tasks = await DatabaseDao.getAllTasks();
    var backupSettigs = await DatabaseDao.getBackupSettings(timeBackup);

    for (var list in lists) {
      await listsTempRef
          .child(list.id.toString())
          .set(DatabaseDao.listMap(list));
    }
    for (var s in sublists) {
      await sublistsTempRef
          .child(s.id.toString())
          .set(DatabaseDao.sublistMap(s));
    }
    for (var e in elements) {
      await elementsTempRef.child(e.id.toString()).set(DatabaseDao.itemMap(e));
    }
    for (var todoitem in todoElements) {
      await todoitemsTempRef
          .child(todoitem.id.toString())
          .set(DatabaseDao.todoElementMap(todoitem));
    }

    for (var task in tasks) {
      await tasksTempRef
          .child(task.id.toString())
          .set(DatabaseDao.taskMap(task));
    }
    await maxIdsTempRef.set(DatabaseDao.backupSettigsMap(backupSettigs));
    var tempData = (await tempRef.get()).value;
    await getBackupRef().set(tempData);
    await getTempBackupRef().set({});
    await DatabaseDao.setLastBackup(timeBackup);
    return true;
  }

  // Function to set backupNeed and try backup in the background
  static void setBackupNeedAndTryBackup() {
    requests++;
    debugPrint("Request nº $requests time ${DateTime.now()}");
    if (_backupRunning) {
      debugPrint("JÁ TEM BACKUP RODANDO ESPERAR");
      _anotherBackupNeed = true;
    } else {
      _backupRunning = true;
      setBackupNeeded(true).then((_) {
        debugPrint("vai tentar backup");
        tryBackup();
      });
    }
  }

  static Future<void> getBackup() async {
    await DatabaseDao.deleteAll(false);
    final listsRef = getListsRef();
    final elementsRef = getElementsRef();
    final sublistsRef = getSublistsRef();
    final todoitemsRef = getTodoItemsRef();
    final tasksRef = getTasksRef();
    final maxIdsRef = getMaxIdsRef();

    final listsDbData = (await listsRef.get()).children;

    for (var listTable in listsDbData) {
      Map<dynamic, dynamic> rawValue = listTable.value as Map;
      Map<String, dynamic> value = rawValue.map(
        (key, value) => MapEntry<String, dynamic>(key.toString(), value),
      );

      await DatabaseDao.addListFromMap(value);
    }

    final sublistsDbData = (await sublistsRef.get()).children
        .map(
          (rawValue) => DatabaseDao.sublistMap2(
            (rawValue.value as Map).map(
              (key, value) => MapEntry<String, dynamic>(key.toString(), value),
            ),
          ),
        )
        .toList();

    var cont = sublistsDbData.length;
    while (cont > 0) {
      var sublist = sublistsDbData[0];
      if (cont == 1) {
        debugPrint('lista removida');
        debugPrint(sublist.toString());
        await DatabaseDao.addSublistFromMap(sublist);
        break;
      }
      if (sublist.hasListParent.value) {
        debugPrint('lista removida');
        debugPrint(sublist.toString());
        await DatabaseDao.addSublistFromMap(sublistsDbData[0]);
        sublistsDbData.remove(sublistsDbData[0]);
      } else {
        var continuar = true;
        while (continuar) {
          //this while exists to nod add a sublist without add all its parent sublists.
          var sublistId = sublist.sublistParent.value!;
          var parentList = sublistsDbData.where(
            (sublist) => sublist.id.value == sublistId,
          );
          if (parentList.isEmpty) {
            await DatabaseDao.addSublistFromMap(sublist);
            debugPrint('lista removida');
            debugPrint(sublist.toString());
            sublistsDbData.remove(sublist);
            break;
          }
          var parent = parentList.first;
          if (parent.hasListParent.value) {
            debugPrint('lista removida');
            debugPrint(parent.toString());
            await DatabaseDao.addSublistFromMap(parent);
            sublistsDbData.remove(parent);
            break;
          } else {
            sublist = parent;
          }
        }
      }
      cont--;
    }

    debugPrint("PASSOU SUBLISTA");

    final elementsDbData = (await elementsRef.get()).children;
    for (var elementTable in elementsDbData) {
      Map<dynamic, dynamic> rawValue = elementTable.value as Map;
      Map<String, dynamic> value = rawValue.map(
        (key, value) => MapEntry<String, dynamic>(key.toString(), value),
      );
      await DatabaseDao.addItemFromMap(value);
    }
    debugPrint("PASSOU ITEMS");

    final todoitemsDbData = (await todoitemsRef.get()).children;
    for (var todoitemTable in todoitemsDbData) {
      Map<dynamic, dynamic> rawValue = todoitemTable.value as Map;
      Map<String, dynamic> value = rawValue.map(
        (key, value) => MapEntry<String, dynamic>(key.toString(), value),
      );
      await DatabaseDao.addTodoElementFromMap(value);
    }
    debugPrint("PASSOU TODOITEMS");

    final tasksDbData = (await tasksRef.get()).children;
    for (var taskTable in tasksDbData) {
      Map<dynamic, dynamic> rawValue = taskTable.value as Map;
      Map<String, dynamic> value = rawValue.map(
        (key, value) => MapEntry<String, dynamic>(key.toString(), value),
      );
      await DatabaseDao.addTaskFromMap(value);
    }
    debugPrint("PASSOU TASKS");

    final maxIdsData = (await maxIdsRef.get());
    final rawValue = maxIdsData.value as Map;
    final value = rawValue.map(
      (key, value) => MapEntry<String, dynamic>(key.toString(), value),
    );
    await DatabaseDao.setBackupSettings(value);
  }

  static Future<void> clearFirebase() async {
    debugPrint("Clear Firebase");
    try {
      await getBaseRef().set({});
    } catch (e) {
      debugPrint("ERROR clearing database: ${e.toString()}");
    }
  }

  // Function to try backup if backupNeed is set true
  static Future<void> tryBackup({bool secondTry = false}) async {
    var isLogged = await DatabaseDao.getLogin();
    if (isLogged == 0) {
      _backupRunning = false;
      return;
    }
    debugPrint("tentando backup");
    bool backupNeeded;
    try {
      backupNeeded = await DatabaseDao.getBackupNeeded();
    } catch (e) {
      debugPrint("Error no backup: ${e.toString()}");
      _timers.addTimer();
      _backupRunning = false;
      return;
    }

    if (backupNeeded) {
      debugPrint("Backup necessário tentar backup");

      backup()
          .then((success) {
            if (!success) {
              debugPrint(
                "Backup não deu certo vai tentar denovo em 15 minutos",
              );
              _backupRunning = false;
              _timers.addTimer();
            } else if (_anotherBackupNeed) {
              debugPrint("backup concluido mas vai fazer outro em seguida");
              _anotherBackupNeed = false;
              debugPrint("fazendo outro backup em seguida");

              tryBackup(secondTry: true);
            } else {
              debugPrint("backup concluido sem ter outro em seguida");
              setBackupNeeded(false).then((_) {
                debugPrint("sem backup na sequencia e backupNeeded é falso");
                cancelAll();
                _backupRunning = false;
              });
            }
          })
          .catchError((error) {
            debugPrint("Error no backup 2: ${error.toString()}");
            debugPrint("Backup não deu certo vai tentar denovo em 15 minutos");
            _backupRunning = false;
            _timers.addTimer();
          });
    } else {
      debugPrint('não é necessário backup');
    }
  }

  static void cancelAll() {
    _timers.cancelAll();
  }
}
