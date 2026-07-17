import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_gtd_manager_2/controllers/dates_function.dart';
import 'package:my_gtd_manager_2/controllers/elemen_parameters.dart';
import 'package:my_gtd_manager_2/controllers/element_base.dart';
import 'package:my_gtd_manager_2/controllers/task_block_events.dart';
import 'package:my_gtd_manager_2/firebase/backup.dart';
import 'package:my_gtd_manager_2/math.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class TableTypes {
  static const elementTable = 0;
  static const todoElementTable = 1;
  static const sublistTable = 2;
  static const listTable = 3;
  static const taskTable = 4;
}

class SublistWithId {
  final int sublistId; //id is -1 when its a reference to main List
  final String name;
  const SublistWithId(this.sublistId, this.name);
}

class BackupSettings {
  final int maxElementId;
  final int maxListId;
  final int maxTodoItemId;
  final int maxTodoListId;
  final String lastBackup;
  final bool plannerShowAll;
  const BackupSettings({
    required this.maxElementId,
    required this.maxListId,
    required this.maxTodoItemId,
    required this.maxTodoListId,
    required this.lastBackup,
    required this.plannerShowAll,
  });
  @override
  String toString() {
    return {
      'maxElementId': maxElementId,
      'maxListId': maxListId,
      'maxTodoItemId': maxTodoItemId,
      'maxTodoListId': maxTodoListId,
      'lastBackup': lastBackup,
      'plannerShowAll': plannerShowAll,
    }.toString();
  }
}

class ListLite {
  final int id;
  final String name;

  const ListLite(this.id, this.name);
}

class ChangeElementSublist {
  int listId;
  int sublistId;
  Map<ListLite, List<SublistWithId>> sublistStructure;
  ChangeElementSublist(this.listId, this.sublistId, this.sublistStructure);
}

class ListData {
  List<ElementBase> elements;
  MyListData listData;
  ListData(this.elements, this.listData);
}

class Settings extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get isBackupNeeded => boolean()();
  DateTimeColumn get lastBackup => dateTime()();
  IntColumn get login => integer()();
  BoolColumn get deleteRelatedThings => boolean()();
}

class DbSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get maxListId => integer()();
  IntColumn get maxElementId => integer()();
  IntColumn get maxTodoListId => integer()();
  IntColumn get maxTodoItemId => integer()();
  BoolColumn get plannerShowAll => boolean()();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 20)();
}
/*class DeletedItems extends Table {
  IntColumn get itemId => integer()();
  IntColumn get tableType => integer()();
  DateTimeColumn get time => dateTime()();
}*/

class TodoItemTags extends Table {
  IntColumn get todoItemId =>
      integer().customConstraint('NOT NULL REFERENCES todo_element(id)')();
  IntColumn get tagId =>
      integer().customConstraint('NOT NULL REFERENCES tags(id)')();

  @override
  Set<Column> get primaryKey => {todoItemId, tagId};
}

class Task extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get creationTime => text()();
  TextColumn get name => text()();
  TextColumn get startingDay => text()();
  TextColumn get finishDay => text().nullable()();
  BoolColumn get flexibleTime => boolean()();
  TextColumn get beginningTime => text().nullable()();
  TextColumn get endingTime => text().nullable()();
  TextColumn get notes => text()();
  IntColumn get repeatType => integer()();
  BoolColumn get customRepeat => boolean()();
  IntColumn get daily => integer().nullable()();
  TextColumn get weekly => text().nullable()();
  IntColumn get monthly => integer().nullable()();
  IntColumn get yearly => integer().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  TextColumn get checkDays => text().withDefault(const Constant(""))();
  BoolColumn get finished => boolean().withDefault(const Constant(false))();
  TextColumn get lastModified => text()();
  IntColumn get relatedElementId => integer().nullable()();
  TextColumn get tags => text().withDefault(const Constant(""))();
}

class TodoElement extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get lastModified => text()();
  TextColumn get position => text()();

  IntColumn get listParent =>
      integer().references(MyList, #id, onDelete: KeyAction.cascade)();
  BoolColumn get isChecked => boolean().withDefault(const Constant(false))();

  TextColumn get notes => text()();
  IntColumn get relatedElementId => integer().nullable()();
  TextColumn get tags => text().withDefault(const Constant(""))();
}

class MyElement extends Table {
  IntColumn get ancestorId => integer()();
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get lastModified => text()();
  TextColumn get position => text()();
  BoolColumn get hasListParent => boolean()();
  IntColumn get listParent => integer().nullable().references(
    MyList,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get sublistParent => integer().nullable().references(
    MySublist,
    #id,
    onDelete: KeyAction.cascade,
  )();
  BoolColumn get isChecked => boolean().withDefault(const Constant(false))();

  TextColumn get notes => text()();
  IntColumn get taskIdRelated => integer().nullable()();
  IntColumn get todoitemIdRelated => integer().nullable()();
  TextColumn get tags => text().withDefault(const Constant(""))();
}

class MySublist extends Table {
  IntColumn get ancestorId => integer()();
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get lastModified => text()();
  TextColumn get position => text()();
  BoolColumn get hasListParent => boolean()();
  IntColumn get listParent => integer().nullable().references(
    MyList,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get sublistParent => integer().nullable().references(
    MySublist,
    #id,
    onDelete: KeyAction.cascade,
  )();
  BoolColumn get isShrinked => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text()();
}

class MyList extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  //BoolColumn get isDragging => boolean().withDefault(const Constant(true))();
  BoolColumn get showAll => boolean().withDefault(const Constant(false))();
  TextColumn get lastModified => text()();
  TextColumn get position => text().withDefault(const Constant(""))();
  BoolColumn get todoList => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(
  tables: [
    MyElement,
    MyList,
    MySublist,
    DbSettings,
    Settings,
    TodoElement,
    Task,
  ],
)
class MyEncryptedDatabase extends _$MyEncryptedDatabase {
  MyEncryptedDatabase({bool test = false})
    : super((!test) ? _openDatabase() : NativeDatabase.memory());

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        customStatement('PRAGMA foreign_keys = ON');
        await _createTriggers();
        DbSetting? myDbSetting = await select(dbSettings).getSingleOrNull();

        if (myDbSetting == null) {
          var dbSettingsValue = const DbSettingsCompanion(
            plannerShowAll: Value(false),
            id: Value(1),
            maxElementId: Value(0),
            maxListId: Value(0),
            maxTodoItemId: Value(0),
            maxTodoListId: Value(0),
          );
          await into(dbSettings).insert(dbSettingsValue);
        }
        Setting? config = await select(settings).getSingleOrNull();
        if (config == null) {
          var initialConfig = SettingsCompanion(
            deleteRelatedThings: const Value(true),
            isBackupNeeded: const Value(false),
            lastBackup: Value(DateTime(1970)),
            login: const Value(0),
          );
          await into(settings).insert(initialConfig);
        }
      },
    );
  }

  Future<void> _createTriggers() async {
    var myElementTable = myElement.actualTableName;
    var todoElementTable = todoElement.actualTableName;
    /*var listTable = myList.actualTableName;
    var sublistTable = mySublist.actualTableName;
    var deleteTable =deletedItems.actualTableName;
    var itemIdCollumn= deletedItems.itemId.name;
    var tableTypeCollumn= deletedItems.tableType.name;
    var timeCollumn = deletedItems.time.name;*/
    var taskTable = task.actualTableName;
    var relatedElementIdCollumn = task.relatedElementId.name;
    var relatedElementIdCollumn2 = todoElement.relatedElementId.name;
    var taskIdRelated = myElement.taskIdRelated.name;
    var todoitemIdRelated = myElement.todoitemIdRelated.name;
    var sqlquery1 =
        '''
      CREATE TRIGGER IF NOT EXISTS before_delete_myelement
      BEFORE DELETE ON $myElementTable
      BEGIN            
        
        UPDATE $taskTable SET $relatedElementIdCollumn = NULL WHERE id = Old.$taskIdRelated;
        UPDATE $todoElementTable SET  $relatedElementIdCollumn2 = NULL WHERE id = Old.$todoitemIdRelated;
      END;
    ''';
    print(sqlquery1);
    await customStatement(sqlquery1);
    var sqlquery2 =
        '''
      CREATE TRIGGER IF NOT EXISTS before_delete_todoElement
      BEFORE DELETE ON $todoElementTable
      BEGIN            
        
        UPDATE $myElementTable SET $todoitemIdRelated = NULL WHERE id = Old.$relatedElementIdCollumn2;
      END;
    ''';
    print(sqlquery2);
    await customStatement(sqlquery2);
    var sqlquery3 =
        '''
      CREATE TRIGGER IF NOT EXISTS before_delete_task
      BEFORE DELETE ON $taskTable
      BEGIN            
        
        UPDATE $myElementTable SET $taskIdRelated = NULL WHERE id = Old.$relatedElementIdCollumn;
      END;
    ''';
    print(sqlquery3);
    await customStatement(sqlquery3);
    /*var sqlquery4='''
      CREATE TRIGGER IF NOT EXISTS before_delete_list
      BEFORE DELETE ON $listTable
      BEGIN            
        INSERT INTO $deleteTable ($itemIdCollumn, $tableTypeCollumn, $timeCollumn) VALUES (OLD.id, ${TableTypes.listTable}, datetime('now'));
        
      END;
    ''';
    print(sqlquery4);
    await customStatement(sqlquery4);
    var sqlquery5='''
      CREATE TRIGGER IF NOT EXISTS before_delete_sublist
      BEFORE DELETE ON $sublistTable
      BEGIN            
        INSERT INTO $deleteTable ($itemIdCollumn, $tableTypeCollumn, $timeCollumn) VALUES (OLD.id, ${TableTypes.listTable}, datetime('now'));
        
      END;
    ''';
    print(sqlquery5);
    await customStatement(sqlquery5);*/
  }
}

String _randomValue() {
  final rand = Random();
  final codeUnits = List.generate(20, (index) {
    return rand.nextInt(26) + 65;
  });

  return String.fromCharCodes(codeUnits);
}

QueryExecutor _openDatabase() {
  return LazyDatabase(() async {
    const storage = FlutterSecureStorage();
    final path = await getApplicationDocumentsDirectory();
    var var1 = await storage.read(key: 'code1');
    if (var1 == null) {
      await storage.write(key: 'code1', value: _randomValue());
      var1 = await storage.read(key: 'code1');
    }

    return NativeDatabase(
      File(p.join(path.path, 'app.db.enc')),
      setup: (db) {
        // Check that we're actually running with SQLCipher by quering the
        // cipher_version pragma.
        final result = db.select('pragma cipher');
        if (result.isEmpty) {
          throw UnsupportedError(
            'This database needs to run with SQLCipher, but that library is '
            'not available!',
          );
        }

        // Then, apply the key to encrypt the database. Unfortunately, this
        // pragma doesn't seem to support prepared statements so we inline the
        // key.
        final escapedKey = var1!.replaceAll("'", "''");
        db.execute("pragma key = '$escapedKey'");

        // Test that the key is correct by selecting from a table
        db.execute('select count(*) from sqlite_master');
      },
    );
  });
}

class SecureStorage {
  static Future<String?> getKey(String key) {
    const secureStorage = FlutterSecureStorage();
    return secureStorage.read(key: key);
  }

  static Future<void> setKey(String key, String value) {
    const secureStorage = FlutterSecureStorage();
    return secureStorage.write(key: key, value: value);
  }
}

class DatabaseDao {
  static late MyEncryptedDatabase _db;
  static Future<String?> getEmail() async {
    return await SecureStorage.getKey('email');
  }

  static Future<String?> getPassword() async {
    return await SecureStorage.getKey('password');
  }

  static Future<void> setEmail(String newEmail) async {
    await SecureStorage.setKey('email', newEmail);
  }

  static Future<void> setPassword(String newPassword) async {
    await SecureStorage.setKey('password', newPassword);
  }

  static Future<void> deleteAll(bool createFirstList) async {
    await _db.delete(_db.mySublist).go();
    await _db.delete(_db.myList).go();
    await _db.delete(_db.myElement).go();
    await _db.delete(_db.task).go();
    await _db.delete(_db.todoElement).go();
    await _db.customStatement(
      "DELETE FROM sqlite_sequence WHERE name = '${_db.mySublist.name.name}'",
    );
    await _db.customStatement(
      "DELETE FROM sqlite_sequence WHERE name = '${_db.myList.name.name}'",
    );
    await _db.customStatement(
      "DELETE FROM sqlite_sequence WHERE name = '${_db.myElement.name.name}'",
    );
    await _db.customStatement(
      "DELETE FROM sqlite_sequence WHERE name = '${_db.task.name.name}'",
    );
    await _db.customStatement(
      "DELETE FROM sqlite_sequence WHERE name = '${_db.todoElement.name.name}'",
    );

    var dbSettingsValue = const DbSettingsCompanion(
      plannerShowAll: Value(false),
      id: Value(1),
      maxElementId: Value(0),
      maxListId: Value(0),
      maxTodoItemId: Value(0),
      maxTodoListId: Value(0),
    );
    await ((_db.update(
      _db.dbSettings,
    )..where((tbl) => tbl.id.equals(1))).write(dbSettingsValue));
    if (createFirstList) {
      await creatFirstsLists();
    }
  }

  static Future<bool> getDeleteData() async {
    return (await getSetting()).deleteRelatedThings;
  }

  static Future<void> changeElementParent({
    required bool isItem,
    required int elementId,
    required int sublistId,
    required int listId,
  }) async {
    var hasListParent = (sublistId == -1);

    String position;
    if (hasListParent) {
      query1($MyElementTable tbl) =>
          tbl.hasListParent.equals(true) & tbl.listParent.equals(listId);
      query2($MySublistTable tbl) =>
          tbl.hasListParent.equals(true) & tbl.listParent.equals(listId);
      var items = await (_db.select(_db.myElement)..where(query1)).get();
      var sublists = await (_db.select(_db.mySublist)..where(query2)).get();
      List<ElementBase> elements = [...items, ...sublists];
      position = (elements.isEmpty)
          ? '0.1'
          : increaseNumber(sortElements(elements).first.position);
    } else {
      var items = await (_db.select(
        _db.myElement,
      )..where((tbl) => tbl.sublistParent.equals(sublistId))).get();
      var sublists = await (_db.select(
        _db.mySublist,
      )..where((tbl) => tbl.sublistParent.equals(sublistId))).get();
      List<ElementBase> elements = [...items, ...sublists];
      position = (elements.isEmpty)
          ? '0.1'
          : increaseNumber(sortElements(elements).first.position);
    }
    var listParent = (hasListParent) ? Value(listId) : const Value(null);
    var sublistParent = (hasListParent) ? const Value(null) : Value(sublistId);
    var ancestorId = Value(listId);

    if (isItem) {
      var changes = {
        ancestorId: ancestorId,
        position: Value(position),
        hasListParent: Value(hasListParent),
        listParent: listParent,
        sublistParent: sublistParent,
      };

      await (_db.update(
        _db.myElement,
      )..where((tbl) => tbl.id.equals(elementId))).write(
        MyElementCompanion(
          lastModified: Value(datetimeToString(DateTime.now())),
          ancestorId: ancestorId,
          position: Value(position),
          hasListParent: Value(hasListParent),
          listParent: listParent,
          sublistParent: sublistParent,
        ),
      );
      Backup.setBackupNeedAndTryBackup();
    } else {
      List<int> itemsId = [];
      List<int> sublistsId = [];
      await getChildren(elementId, itemsId, sublistsId);

      var transactionfail = false;

      await _db.transaction(() async {
        var update3 =
            await (_db.update(
              _db.mySublist,
            )..where((tbl) => tbl.id.equals(elementId))).write(
              MySublistCompanion(
                ancestorId: ancestorId,
                lastModified: Value(datetimeToString(DateTime.now())),
                position: Value(position),
                hasListParent: Value(hasListParent),
                listParent: listParent,
                sublistParent: sublistParent,
              ),
            );
        var update1 =
            await (_db.update(
              _db.myElement,
            )..where((tbl) => tbl.id.isIn(itemsId))).write(
              MyElementCompanion(
                ancestorId: Value(listId),
                lastModified: Value(datetimeToString(DateTime.now())),
              ),
            );
        var update2 =
            await (_db.update(
              _db.mySublist,
            )..where((tbl) => tbl.id.isIn(sublistsId))).write(
              MySublistCompanion(
                ancestorId: Value(listId),
                lastModified: Value(datetimeToString(DateTime.now())),
              ),
            );

        if (update1 != itemsId.length ||
            update2 != sublistsId.length ||
            update3 != 1) {
          transactionfail = true;
          throw Exception("rool back");
        }
      });

      if (!transactionfail) {
        Backup.setBackupNeedAndTryBackup();
      }
    }
  }

  static Future<void> creatFirstsLists() async {
    _db.transaction(() async {
      await addList('Some day/maybe', true, callBackup: false);
      await addList('Next actions', true, callBackup: false);
      await addList('Inbox', true, callBackup: false);
    });
  }

  static Future<void> getChildren(
    int sublistId,
    List<int> itemsIds,
    List<int> sublistsIds, {
    bool firstTime = true,
  }) async {
    if (!firstTime) sublistsIds.add(sublistId);
    var items = await (_db.select(
      _db.myElement,
    )..where((tbl) => tbl.sublistParent.equals(sublistId))).get();

    for (var item in items) {
      itemsIds.add(item.id);
    }
    var sublistsChildren = await (_db.select(
      _db.mySublist,
    )..where((tbl) => tbl.sublistParent.equals(sublistId))).get();

    for (var sublist in sublistsChildren) {
      await getChildren(sublist.id, itemsIds, sublistsIds, firstTime: false);
    }
  }

  /*static Future<void> deleteRelatedElement (
    { 
      required int projectId,
      required bool isTask,
      required int relatedId,
      
    }) async{
    
    var elementData = await (_db.select(_db.myElement)..where((tbl) => tbl.id.equals(projectId))).getSingleOrNull();
    if (elementData==null) return;
    var tasks=stringToList(elementData.tasksIdRelated);
    var items = elementData.todoitemsIdRelated;
    if(isTask){
      tasks = removeTaskInList(tasks, relatedId);
    } else {
      items = removeItemInList(items, relatedId);
    }
    bool isChecked=true;
    if(!elementData.isChecked){
      isChecked=(items.indexWhere((value) => value.isChecked==false) == -1 && tasks.indexWhere((value) => value.checked==false)==-1);

    } 
    var newElement=MyElementCompanion(
      lastModified: Value(datetimeToString(DateTime.now())),
      tasksIdRelated: Value(listToString(tasks)),
      todoitemsIdRelated: Value(items),
      isChecked: Value(isChecked),
    );
    (_db.update(_db.myElement)..where((tbl) => tbl.id.equals(projectId))).write(newElement);
  }*/
  /*static Future<void> changeRelatedElement (
    { 
      required int projectId,
      required bool isTask,
      required int relatedId,
      required bool value,
    }) async{
    var elementData = await (_db.select(_db.myElement)..where((tbl) => tbl.id.equals(projectId))).getSingleOrNull();
    if (elementData==null) return;
    var task=elementData.taskIdRelated;
    var item =elementData.todoitemIdRelated;
    debugPrint("Before");
    debugPrint("ITEM:$item");
    debugPrint("TASK:$task");
    if (isTask){
      if(value){
        
      }else{
        tasks=uncheckTaskInList(tasks, relatedId);
      }
    }else{
      if(value){
        items=checkItemInList(items, relatedId);
      }else{
        items=uncheckItemInList(items, relatedId);
      }
    }
    bool isCheckedProject;
    debugPrint("After");
    debugPrint("ITEMS:$items");
    debugPrint("TASKS:$tasks");
    
    if (value) {
      debugPrint("value true");
      isCheckedProject=(items.indexWhere((value) => value.isChecked==false) == -1 && tasks.indexWhere((value) => value.checked==false)==-1);
      debugPrint("isCheckedProject: $isCheckedProject");
    } else {
      if (elementData.isChecked){
        var uncheckedItems=items.where((element) => element.isChecked==false).length;
        var uncheckedTasks=tasks.where((element) => element.checked==false).length;
        if(uncheckedItems+uncheckedTasks==1){
          isCheckedProject =false;
        } else{
          isCheckedProject=elementData.isChecked;
        }
      }else{
        isCheckedProject=elementData.isChecked;
      } 
    }
    
    var newElement=MyElementCompanion(
      lastModified: Value(datetimeToString(DateTime.now())),
      tasksIdRelated: Value(listToString(tasks)),
      todoitemsIdRelated: Value(items),
      isChecked: Value((isCheckedProject)),

    );
    (_db.update(_db.myElement)..where((tbl) => tbl.id.equals(projectId))).write(newElement);
  
  
  }*/

  static Future<void> uncheckTask(int taskId, DateTime date) async {
    await _db.transaction(() async {
      var task = await (_db.select(
        _db.task,
      )..where((tbl) => tbl.id.equals(taskId))).getSingle();
      var list = stringToListOfDates(task.checkDays).toList();

      removeDateToList(list, date);

      var newTask = TaskCompanion(
        lastModified: Value(datetimeToString(DateTime.now())),
        checkDays: Value(listOfDatesToString(list)),
      );
      await (_db.update(
        _db.task,
      )..where((tbl) => tbl.id.equals(taskId))).write(newTask);
      if (task.relatedElementId != null && task.repeatType == 0) {
        var projectId = task.relatedElementId!;
        await changeElementIsChecked(false, projectId);
      }
    });

    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> openDb({bool test = false}) async {
    _db = MyEncryptedDatabase(test: test);
  }

  static Future<void> closeDb() async {
    _db.close();
  }

  static Stream<String> listNameStream(int listId) {
    return (_db.select(_db.myList)..where((tbl) => tbl.id.equals(listId)))
        .watchSingle()
        .map((list) => list.name);
  }

  static Stream<TaskBlocEvent> showAllStream(int listId) {
    return (_db.select(_db.myList)..where((tbl) => tbl.id.equals(listId)))
        .watchSingle()
        .map((list) => ShowAllEvent(list.showAll))
        .distinct((prev, next) {
          return (prev == next);
        });
  }

  static Stream<TaskBlocEvent> showAllPlannerStream() {
    return (_db.select(_db.dbSettings))
        .watchSingle()
        .map((setting) {
          return ShowAllEvent(setting.plannerShowAll);
        })
        .distinct((prev, next) {
          return (prev == next);
        });
  }

  static Stream<dynamic> sublistsStream(int listId) {
    return (_db.select(
      _db.mySublist,
    )..where((sbl) => sbl.ancestorId.equals(listId))).watch();
  }

  static Stream<List<MyListData>> listsStream() {
    return (_db.select(
      _db.myList,
    )..where((tbl) => tbl.todoList.equals(false))).watch();
  }

  static Stream<List<MyListData>> todoListsStream() {
    return (_db.select(
      _db.myList,
    )..where((tbl) => tbl.todoList.equals(true))).watch();
  }

  static Stream<TaskBlocEvent> tasksStream() {
    return _db.select(_db.task).watch().map((tasks) {
      return TaskListEvent(tasks);
    });
  }

  static Stream<dynamic> elementsStream(int listId) {
    final query = (_db.select(_db.myElement)
      ..where((tbl) => tbl.ancestorId.equals(listId)));
    return query.watch();
  }

  static Stream<dynamic> todoelementsStream(int listId) {
    final query = (_db.select(_db.todoElement)
      ..where((tbl) => tbl.listParent.equals(listId)));

    return query.watch();
  }

  static Stream<dynamic> listStream(int listId) {
    final query = (_db.select(_db.myList)
      ..where((tbl) => tbl.id.equals(listId)));
    return query.watchSingle();
  }

  static Future<void> changeTodoItemOrder(
    int elementId,
    String position,
  ) async {
    await (_db.update(
      _db.todoElement,
    )..where((tbl) => tbl.id.equals(elementId))).write(
      TodoElementCompanion(
        lastModified: Value(datetimeToString(DateTime.now())),
        position: Value(position),
      ),
    );
    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> changeElementOrder(
    int elementId,
    bool hasListParent,
    int listParentId,
    String position,
    bool isItem,
  ) async {
    if (isItem) {
      await (_db.update(
        _db.myElement,
      )..where((tbl) => tbl.id.equals(elementId))).write(
        MyElementCompanion(
          position: Value(position),
          lastModified: Value(datetimeToString(DateTime.now())),
          hasListParent: Value(hasListParent),
          sublistParent: (hasListParent)
              ? const Value(null)
              : Value(listParentId),
        ),
      );
    } else {
      await (_db.update(
        _db.mySublist,
      )..where((tbl) => tbl.id.equals(elementId))).write(
        MySublistCompanion(
          position: Value(position),
          hasListParent: Value(hasListParent),
          lastModified: Value(datetimeToString(DateTime.now())),
          sublistParent: (hasListParent)
              ? const Value(null)
              : Value(listParentId),
        ),
      );
    }
    Backup.setBackupNeedAndTryBackup();
  }

  static List<ElementBase> sortElements(List<ElementBase> list) {
    list.sort((a, b) {
      return myCompareTo(b.position, a.position);
    });
    return list;
  }

  static Future<List<MyListData>> allTodoLists() {
    return (_db.select(
      _db.myList,
    )..where((tbl) => tbl.todoList.equals(true))).get();
  }

  static Future<ChangeElementSublist> getChangeElementSublist(
    bool isItem,
    int id,
  ) async {
    int listId;
    int sublistId;
    Map<ListLite, List<SublistWithId>> databaseStructure = {};
    List<MyListData> lists = await (_db.select(
      _db.myList,
    )..where((tbl) => tbl.todoList.equals(false))).get();
    List<MySublistData> allsublists = await _db.select(_db.mySublist).get();
    lists.sort(((a, b) => myCompareTo(b.position, a.position)));
    for (var list in lists) {
      List<MySublistData> sublistsInVarList = allsublists
          .where((sublist) => sublist.ancestorId == list.id)
          .toList();
      List<MySublistData> result = [];
      _getSublistsList(sublistsInVarList, result, list.id);
      List<SublistWithId> sublists = [];
      for (var sublist in result) {
        sublists.add(SublistWithId(sublist.id, sublist.name));
      }
      databaseStructure[ListLite(list.id, list.name)] = sublists;
    }

    if (isItem) {
      var item = await getElement(id);

      sublistId = (item.hasListParent) ? -1 : item.sublistParent!;
    } else {
      var sublist = await getSublist(id);

      sublistId = (sublist.hasListParent) ? -1 : sublist.sublistParent!;
    }
    if (sublistId == -1) {
      if (isItem) {
        listId = (await getElement(id)).listParent!;
      } else {
        listId = (await getSublist(id)).listParent!;
      }
      return ChangeElementSublist(listId, sublistId, databaseStructure);
    }
    MySublistData sublistParent = await getSublist(sublistId);
    while (sublistParent.hasListParent == false) {
      sublistParent = await getSublist(sublistParent.sublistParent!);
    }
    listId = sublistParent.listParent!;
    return ChangeElementSublist(listId, sublistId, databaseStructure);
  }

  //get all elements of a list view and put it in order
  static List<ElementParameters> elementsTile(
    List<ElementBase> allElements,
    int id,
  ) {
    //allElements are allElements of a list,
    List<ElementParameters> result = [];

    _getElements(allElements, result, 0, id);
    return result;
  }

  static void _getSublistsList(
    List<MySublistData> allSublists,
    List<MySublistData> result,
    int listId, {
    bool hasListParent = true,
  }) {
    var sublists = allSublists
        .where(
          (sublist) =>
              sublist.getParentId() == listId &&
              sublist.hasListParent == hasListParent,
        )
        .toList();
    sublists.sort((a, b) {
      return myCompareTo(b.position, a.position);
    });
    for (var sublist in sublists) {
      result.add(sublist);
      _getSublistsList(allSublists, result, sublist.id, hasListParent: false);
    }
  }

  //helper for a elementsTile
  static void _getElements(
    List<ElementBase> allElements,
    List<ElementParameters> result,
    int deepth,
    int listID, {
    bool hasListParent = true,
  }) {
    var listElements = allElements
        .where(
          (element) =>
              element.getParentId() == listID &&
              element.hasListParent == hasListParent,
        )
        .toList();

    //debugPrint("listElements.lenght: ${listElements.length}");

    var listElementsOrderded = DatabaseDao.sortElements(listElements);
    for (var cont = 0; cont < listElementsOrderded.length; cont++) {
      var element = listElementsOrderded[cont];
      result.add(ElementParameters(element, deepth));

      if (element is MySublistData) {
        _getElements(
          allElements,
          result,
          deepth + 1,
          element.id,
          hasListParent: false,
        );
      }
    }
  }

  static Future<List<MyElementData>> getAllItems() {
    return _db.select(_db.myElement).get();
  }

  static Future<List<MyListData>> getAllLists() {
    return _db.select(_db.myList).get();
  }

  static Future<List<MyListData>> getAllTodoLists() {
    return (_db.select(
      _db.myList,
    )..where((tbl) => tbl.todoList.equals(true))).get();
  }

  static Future<List<MySublistData>> getAllSublists() {
    return _db.select(_db.mySublist).get();
  }

  static Future<List<MyElementData>> getItems(int listId) {
    return (_db.select(
      _db.myElement,
    )..where((tbl) => tbl.ancestorId.equals(listId))).get();
  }

  static Future<List<TodoElementData>> getAllTodoItems() {
    return _db.select(_db.todoElement).get();
  }

  static Future<List<TaskData>> getAllTasks() {
    return _db.select(_db.task).get();
  }

  static Future<List<MySublistData>> getSublists(int listId) {
    return (_db.select(
      _db.mySublist,
    )..where((tbl) => tbl.ancestorId.equals(listId))).get();
  }

  static List<MyListData> myListsOrderded(List<MyListData> list) {
    var result = list;
    result.sort((a, b) {
      var aOnTop = (a.id >= 1 && a.id <= 3);
      var bOnTop = (b.id >= 1 && b.id <= 3);
      if (aOnTop && bOnTop) {
        return b.id.compareTo(a.id);
      }
      if (aOnTop && !bOnTop) {
        return -1;
      }
      if (!aOnTop && bOnTop) {
        return 1;
      }
      var pos1 = double.parse(a.position);
      var pos2 = double.parse(b.position);
      return pos2.compareTo(pos1);
    });
    return result;
  }

  static Future<void> addListFromMap(Map<String, dynamic> map) async {
    var list = MyListCompanion.insert(
      id: Value(map['id']),
      name: map['name'],
      lastModified: map['lastModified'],
      showAll: Value(map['showAll']),
      //isDragging: Value(map['isDragging']),
      position: Value(map['position']),
      todoList: Value(map['todoList']),
    );
    await _db.into(_db.myList).insert(list);
  }

  static Map<String, dynamic> taskMap(TaskData t) {
    return {
      'tags': t.tags,
      'id': t.id,
      'creationTime': t.creationTime,
      'name': t.name,
      'startingDay': t.startingDay,
      'flexibleTime': t.flexibleTime,
      'beginningTime': (t.beginningTime == null) ? "-1" : t.beginningTime,
      'endingTime': (t.endingTime == null) ? "-1" : t.endingTime,
      'repeatType': t.repeatType,
      'daily': (t.daily == null) ? -1 : t.daily,
      'weekly': (t.weekly == null) ? "-1" : t.weekly,
      'monthly': (t.monthly == null) ? -1 : t.monthly,
      'yearly': (t.yearly == null) ? -1 : t.yearly,
      'relatedElementId': (t.relatedElementId == null)
          ? -1
          : t.relatedElementId,
      'active': t.active,
      'checkDays': t.checkDays,
      'finished': t.finished,
      'lastModified': t.lastModified,
      'notes': t.notes,
      'customRepeat': t.customRepeat,
    };
  }

  static Future<void> addTaskFromMap(Map<String, dynamic> task) async {
    var newTask = TaskCompanion.insert(
      tags: Value(task['tags']),
      customRepeat: task['customRepeat'],
      notes: task['notes'],
      id: Value(task['id']),
      creationTime: task['creationTime'],
      name: task['name'],
      startingDay: task['startingDay'],
      flexibleTime: task['flexibleTime'],
      beginningTime: (task['beginningTime'] == "-1")
          ? const Value(null)
          : Value(task['beginningTime']),
      endingTime: (task['endingTime'] == "-1")
          ? const Value(null)
          : Value(task['endingTime']),
      repeatType: task['repeatType'],
      daily: (task['daily'] == -1) ? const Value(null) : Value(task['daily']),
      weekly: (task['weekly'] == "-1")
          ? const Value(null)
          : Value(task['weekly']),
      monthly: (task['monthly'] == -1)
          ? const Value(null)
          : Value(task['monthly']),
      yearly: (task['yearly'] == -1)
          ? const Value(null)
          : Value(task['yearly']),

      active: Value(task['active']),
      checkDays: Value(task['checkDays']),
      lastModified: task['lastModified'],
      relatedElementId: (task['relatedElementId'] == -1)
          ? const Value(null)
          : Value(task['relatedElementId']),
    );
    await _db.into(_db.task).insert(newTask);
  }

  static Map<String, dynamic> listMap(MyListData l) {
    return {
      'id': l.id,
      'name': l.name,
      //'isDragging': l.isDragging,
      'showAll': l.showAll,
      'lastModified': l.lastModified,
      'position': l.position,
      'todoList': l.todoList,
    };
  }

  static Map<String, dynamic> sublistMap(MySublistData s) {
    return {
      'ancestorId': s.ancestorId,
      'id': s.id,
      'name': s.name,
      'lastModified': s.lastModified,
      'position': s.position,
      'hasListParent': s.hasListParent,
      'listParent': (s.listParent == null) ? -1 : s.listParent,
      'sublistParent': (s.sublistParent == null) ? -1 : s.sublistParent,
      'isShrinked': s.isShrinked,
      'notes': s.notes,
    };
  }

  static MySublistCompanion sublistMap2(Map<String, dynamic> map) {
    return MySublistCompanion.insert(
      ancestorId: map['ancestorId'],
      id: Value(map['id']),
      name: map['name'],
      lastModified: map['lastModified'],
      notes: map['notes'],
      position: map['position'],
      hasListParent: map['hasListParent'],
      listParent: (map['listParent'] == -1)
          ? const Value(null)
          : Value(map['listParent']),
      sublistParent: (map['sublistParent'] == -1)
          ? const Value(null)
          : Value(map['sublistParent']),
      isShrinked: Value(map['isShrinked']),
    );
  }

  static Future<void> addSublistFromMap(MySublistCompanion element) async {
    await _db.into(_db.mySublist).insert(element);
  }

  static Future<void> addItemFromMap(Map<String, dynamic> map) async {
    var element = MyElementCompanion.insert(
      notes: map['notes'],
      id: Value(map['id']),
      ancestorId: map['ancestorId'],
      name: map['name'],
      lastModified: map['lastModified'],
      position: map['position'],
      hasListParent: map['hasListParent'],
      listParent: (map['listParent'] == -1)
          ? const Value(null)
          : Value(map['listParent']),
      sublistParent: (map['sublistParent'] == -1)
          ? const Value(null)
          : Value(map['sublistParent']),
      isChecked: Value(map['isChecked']),
      taskIdRelated: Value(map['taskIdRelated']),
      todoitemIdRelated: Value(map['todoitemIdRelated']),
      tags: Value(map['tags']),
    );
    await _db.into(_db.myElement).insert(element);
  }

  static Map<String, dynamic> itemMap(MyElementData e) {
    return {
      'notes': e.notes,
      'ancestorId': e.ancestorId,
      'id': e.id,
      'name': e.name,
      'lastModified': e.lastModified,
      'position': e.position,
      'hasListParent': e.hasListParent,
      'listParent': (e.listParent == null) ? -1 : e.listParent,
      'sublistParent': (e.sublistParent == null) ? -1 : e.sublistParent,
      'isChecked': e.isChecked,
      'tasksIdRelated': (e.taskIdRelated == null) ? -1 : e.taskIdRelated,
      'todoitemsIdRelated': (e.todoitemIdRelated == null)
          ? -1
          : e.todoitemIdRelated,
      'tags': e.tags,
    };
  }

  static Map<String, dynamic> backupSettigsMap(BackupSettings backupSettings) {
    return {
      'maxElementId': backupSettings.maxElementId,
      'maxListId': backupSettings.maxListId,
      'maxTodoItemId': backupSettings.maxTodoItemId,
      'maxTodoListId': backupSettings.maxTodoListId,
      'lastBackup': backupSettings.lastBackup,
      'plannerShowAll': backupSettings.plannerShowAll,
    };
  }

  static Future<void> addTodoElementFromMap(Map<String, dynamic> map) async {
    var element = TodoElementCompanion.insert(
      tags: Value(map['tags']),
      id: Value(map['id']),
      notes: map['notes'],
      name: map['name'],
      lastModified: map['lastModified'],
      position: map['position'],
      listParent: map['listParent'],
      isChecked: Value(map['isChecked']),
      relatedElementId: ((map['relatedElementId'] as int) == -1)
          ? const Value(null)
          : Value(map['relatedElementId']),
    );
    await _db.into(_db.todoElement).insert(element);
  }

  static Map<String, dynamic> todoElementMap(TodoElementData t) {
    return {
      'tags': t.tags,
      'notes': t.notes,
      'id': t.id,
      'name': t.name,
      'lastModified': t.lastModified,
      'position': t.position,
      'listParent': t.listParent,
      'isChecked': t.isChecked,
      'relatedElementId': (t.relatedElementId == null)
          ? -1
          : t.relatedElementId,
    };
  }

  static Future<void> addTodoItem(
    String text,
    int listId,
    String notes, {
    int? projectId,
  }) async {
    if (text.trim() == '') return;
    var element = TodoElementCompanion.insert(
      notes: notes,
      name: text,
      lastModified: datetimeToString(DateTime.now()),
      position: await getNewTodoItemPosition(),
      listParent: listId,
      relatedElementId: Value(projectId),
    );
    await _db.transaction(() async {
      var itemId = await _db.into(_db.todoElement).insert(element);
      await addTodoItemId();
      if (projectId != null) {
        var newElement = MyElementCompanion(
          lastModified: Value(datetimeToString(DateTime.now())),
          todoitemIdRelated: Value(itemId),
        );
        await (_db.update(
          _db.myElement,
        )..where((tbl) => tbl.id.equals(projectId))).write(newElement);
      }
    });

    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> addElement({
    required int ancestorId,
    required String name,
    required int option,
    required int parentID,
    required bool listIsParent,
    String notes = "",
    isChecked = false,
  }) async {
    if (name.trim() == '') return;
    var isItem = option == 0;

    var position = await getNewElementPosition();
    var horaStr = datetimeToString(DateTime.now());
    var hora = stringToDateTime(horaStr);
    if (isItem) {
      var element = MyElementCompanion(
        ancestorId: Value(ancestorId),
        hasListParent: Value(listIsParent),
        name: Value(name),
        listParent: listIsParent ? Value(parentID) : const Value(null),
        sublistParent: !listIsParent ? Value(parentID) : const Value(null),
        position: Value(position),
        lastModified: Value(datetimeToString(DateTime.now())),
        isChecked: Value(isChecked),
        notes: Value(notes),
      );
      await _db.into(_db.myElement).insert(element);
    } else {
      var element = MySublistCompanion(
        notes: Value(notes),
        ancestorId: Value(ancestorId),
        hasListParent: Value(listIsParent),
        name: Value(name),
        listParent: listIsParent ? Value(parentID) : const Value(null),
        sublistParent: !listIsParent ? Value(parentID) : const Value(null),
        position: Value(position),
        lastModified: Value(datetimeToString(DateTime.now())),
      );
      await _db.into(_db.mySublist).insert(element);
    }
    await addElementId();

    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> addMaxListId() async {
    var newValue = await getMaxListId();
    var newMax = DbSettingsCompanion(maxListId: Value(newValue + 1));
    await (_db.update(
      _db.dbSettings,
    )..where((tbl) => tbl.id.equals(1))).write(newMax);
  }

  static Future<void> setBackupSettings(
    Map<String, dynamic> backupSettings,
  ) async {
    var newMaxIds = DbSettingsCompanion.insert(
      maxListId: backupSettings['maxListId'] as int,
      maxElementId: backupSettings['maxElementId'] as int,
      maxTodoListId: backupSettings['maxTodoListId'] as int,
      maxTodoItemId: backupSettings['maxTodoItemId'] as int,
      plannerShowAll: backupSettings['plannerShowAll'] as bool,
    );
    var newSettings = SettingsCompanion(
      lastBackup: Value(
        stringToDateTime(backupSettings['lastBackup'] as String)!,
      ),
    );
    await (_db.update(
      _db.dbSettings,
    )..where((tbl) => tbl.id.equals(1))).write(newMaxIds);
    await (_db.update(
      _db.settings,
    )..where((tbl) => tbl.id.equals(1))).write(newSettings);
  }

  static Future<void> addElementId() async {
    var newValue = await getMaxElementId();
    var newMax = DbSettingsCompanion(maxElementId: Value(newValue + 1));
    await (_db.update(
      _db.dbSettings,
    )..where((tbl) => tbl.id.equals(1))).write(newMax);
  }

  static Future<void> addTodoItemId() async {
    var newValue = await getMaxTodoItemId();

    var newMax = DbSettingsCompanion(maxTodoItemId: Value(newValue + 1));
    await (_db.update(
      _db.dbSettings,
    )..where((tbl) => tbl.id.equals(1))).write(newMax);
    newValue = await getMaxTodoItemId();
  }

  static Future<Setting> getSetting() async {
    return await _db.select(_db.settings).getSingle();
  }

  static Future<BackupSettings> getBackupSettings(DateTime timeBackup) async {
    var dbSettings = await _db.select(_db.dbSettings).getSingle();

    return BackupSettings(
      maxElementId: dbSettings.maxElementId,
      maxListId: dbSettings.maxListId,
      maxTodoItemId: dbSettings.maxTodoItemId,
      maxTodoListId: dbSettings.maxTodoListId,
      lastBackup: datetimeToString(timeBackup),
      plannerShowAll: dbSettings.plannerShowAll,
    );
  }

  static Future<BackupSettings> getBackupSettings2() async {
    var dbSettings = await _db.select(_db.dbSettings).getSingle();
    var timeBackup = (await _db.select(_db.settings).getSingle()).lastBackup;
    var plannerShowAll = dbSettings.plannerShowAll;
    return BackupSettings(
      maxElementId: dbSettings.maxElementId,
      maxListId: dbSettings.maxListId,
      maxTodoItemId: dbSettings.maxTodoItemId,
      maxTodoListId: dbSettings.maxTodoListId,
      lastBackup: datetimeToString(timeBackup),
      plannerShowAll: plannerShowAll,
    );
  }

  static Future<int> getLogin() async {
    return (await getSetting()).login;
  }

  static Future<bool> getBackupNeeded() async {
    return (await getSetting()).isBackupNeeded;
  }

  static Future<DateTime> getLastBackup() async {
    return (await getSetting()).lastBackup;
  }

  static Future<void> setLastBackup(DateTime lastBackup) async {
    (_db.update(_db.settings)..where((tbl) => tbl.id.equals(1))).write(
      SettingsCompanion(lastBackup: Value(lastBackup)),
    );
  }

  static Future<void> setConfig(SettingsCompanion newConfig) async {
    await (_db.update(
      _db.settings,
    )..where((tbl) => tbl.id.equals(1))).write(newConfig);
  }

  static Future<void> setBackupNeed(bool newValue) async {
    var newConfig = SettingsCompanion(isBackupNeeded: Value(newValue));
    await setConfig(newConfig);
  }

  static Future<void> setLogin(int l) async {
    (_db.update(_db.settings)..where((tbl) => tbl.id.equals(1))).write(
      SettingsCompanion(login: Value(l)),
    );
  }

  static Future<void> addTask({required TaskCompanion task}) async {
    var id = task.relatedElementId.value;

    if (id != null) {
      await _db.transaction(() async {
        var taskId = await _db.into(_db.task).insert(task);

        var elementUpdate = MyElementCompanion(
          lastModified: Value(datetimeToString(DateTime.now())),
          taskIdRelated: Value(taskId),
          isChecked: const Value(false),
        );
        await (_db.update(
          _db.myElement,
        )..where((tbl) => tbl.id.equals(id))).write(elementUpdate);
      });
    } else {
      await _db.into(_db.task).insert(task);
    }

    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> changeTask({
    required TaskCompanion task,
    required int taskId,
  }) async {
    await (_db.update(
      _db.task,
    )..where((tbl) => tbl.id.equals(taskId))).write(task);
    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> checkTask(int taskId, DateTime date) async {
    await _db.transaction(() async {
      var task = await (_db.select(
        _db.task,
      )..where((tbl) => tbl.id.equals(taskId))).getSingle();
      var list = stringToListOfDates(task.checkDays).toList();
      addDateToList(list, date);

      var updateTask = TaskCompanion(
        lastModified: Value(datetimeToString(DateTime.now())),
        checkDays: Value(listOfDatesToString(list)),
      );
      await (_db.update(
        _db.task,
      )..where((tbl) => tbl.id.equals(taskId))).write(updateTask);
      if (task.relatedElementId != null && task.repeatType == 0) {
        var projectId = task.relatedElementId!;
        var elementUpdate = MyElementCompanion(
          lastModified: Value(datetimeToString(DateTime.now())),
          isChecked: const Value(true),
        );
        await (_db.update(
          _db.myElement,
        )..where((tbl) => tbl.id.equals(projectId))).write(elementUpdate);
      }
    });

    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> finishTask({
    required int taskId,
    required DateTime? date,
    required int? projectId,
  }) async {
    _db.transaction(() async {
      var newTask = TaskCompanion(
        lastModified: Value(datetimeToString(DateTime.now())),
        finished: const Value(true),
        finishDay: Value(datetimeToString(date)),
      );
      await (_db.update(
        _db.task,
      )..where((tbl) => tbl.id.equals(taskId))).write(newTask);
      if (projectId != null) {
        var elementUpdate = MyElementCompanion(
          isChecked: const Value(true),
          lastModified: Value(datetimeToString(DateTime.now())),
        );
        await (_db.update(
          _db.myElement,
        )..where((tbl) => tbl.id.equals(projectId))).write(elementUpdate);
      }
    });

    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> unfinishTask(int taskId, int? projectId) async {
    _db.transaction(() async {
      var taskData = await (_db.select(
        _db.task,
      )..where((tbl) => tbl.id.equals(taskId))).getSingle();
      var newTask = TaskCompanion(
        checkDays: (taskData.repeatType == 0)
            ? const Value("")
            : Value(taskData.checkDays),
        finished: const Value(false),
        finishDay: const Value(null),
        lastModified: Value(datetimeToString(DateTime.now())),
      );
      await (_db.update(
        _db.task,
      )..where((tbl) => tbl.id.equals(taskId))).write(newTask);
      if (projectId != null) {
        var elementUpdate = MyElementCompanion(
          isChecked: const Value(false),
          lastModified: Value(datetimeToString(DateTime.now())),
        );
        await (_db.update(
          _db.myElement,
        )..where((tbl) => tbl.id.equals(projectId))).write(elementUpdate);
      }
    });
    Backup.setBackupNeedAndTryBackup();
  }

  static bool filterTask(TaskData task, DateTime date) {
    int dateNumber = datetimeToInt(date);

    if (task.finished) {
      var finishDayNum = datetimeToInt(stringToDateTime(task.finishDay)!);

      if (dateNumber > finishDayNum) {
        return false;
      }
    }
    DateTime dateTask = stringToDateTime(task.startingDay)!;

    int dateTaskNumber = datetimeToInt(dateTask);

    if (dateNumber < dateTaskNumber) {
      return false;
    }
    if (dateNumber == dateTaskNumber) {
      return true;
    }
    //dateNumber>dateTaskNumber
    switch (task.repeatType) {
      case 0:
        return false;
      case 1:
        var daily = task.daily!;
        if ((dateNumber - dateTaskNumber) % daily == 0) {
          return true;
        } else {
          return false;
        }
      case 2:
        List<bool> daysBool = List.generate(7, (index) => false);
        var weeklyStr = task.weekly!;
        var weeklySplit = weeklyStr.split('#');
        var weekly = int.parse(weeklySplit[0]);
        var daysStr = weeklySplit[1];
        if (daysStr == '0000000') {
          var weekday = dateTask.weekday - 1;
          daysStr = List.generate(
            7,
            (index) => (index == weekday) ? '1' : '0',
          ).join('');
        }

        for (var index = 0; index < daysStr.length; index++) {
          if (daysStr[index] == '1') {
            daysBool[index] = true;
          } else {
            daysBool[index] = false;
          }
        }
        var weekday = date.weekday - 1;
        if (!daysBool[weekday]) {
          return false;
        }
        //My interpretation
        var helper = (weekday - (dateTask.weekday - 1));
        if (helper < 0) helper += 7;
        var firstTaskInWeekDayNumber = dateTaskNumber + helper;
        if ((dateNumber - firstTaskInWeekDayNumber) % (weekly * 7) == 0) {
          return true;
        } else {
          return false;
        }

      /*Google interpretation*/
      /*var helper = (weekday -(dateTask.weekday-1));
      
      var firstTaskInWeekDayNumber = dateTaskNumber +helper;
      if((dateNumber-firstTaskInWeekDayNumber)%(weekly*7)==0){
        return true;
      } else {
        return false;
      }*/
      case 3:
        if (date.day != dateTask.day) return false;
        var dateNumber1 = ((date.year - 1) * 12) + (date.month - 1);
        var dateTaskNumber1 = ((dateTask.year - 1) * 12) + (dateTask.month - 1);
        var monthly = task.monthly!;
        if ((dateTaskNumber1 - dateNumber1) % monthly == 0) {
          return true;
        } else {
          return false;
        }
      case 4:
        var yearly = task.yearly!;
        if (date.day != dateTask.day || date.month != dateTask.month) {
          return false;
        }
        if ((date.year - dateTask.year) % yearly == 0) {
          return true;
        } else {
          return false;
        }

      default:
        throw Exception("invalid task");
    }
  }

  static Future<int> getMaxTodoItemId() async {
    var maxIds = await _db.select(_db.dbSettings).getSingle();
    return maxIds.maxTodoItemId;
  }

  static Future<int> getMaxListId() async {
    var maxIds = await _db.select(_db.dbSettings).getSingle();
    return maxIds.maxListId;
  }

  static Future<int> getMaxElementId() async {
    var maxIds = await _db.select(_db.dbSettings).getSingle();
    return maxIds.maxElementId;
  }

  static Future<String> getNewTodoListPosition() async {
    var intPosition = await getMaxListId();
    return (intPosition == 0) ? "0.1" : intPosition.toString();
  }

  static Future<String> getNewTodoItemPosition() async {
    var intPosition = await getMaxTodoItemId();
    return (intPosition == 0) ? "0.1" : intPosition.toString();
  }

  static Future<String> getNewListPosition() async {
    var intPosition = await getMaxListId();
    var position = (intPosition == 0) ? "0.1" : intPosition.toString();
    return position;
  }

  static Future<String> getNewElementPosition() async {
    var maxElementId = await getMaxElementId();
    if (maxElementId == 0) {
      return "0.1";
    } else {
      return maxElementId.toString();
    }
  }

  static Future<void> addList(
    String name,
    bool isTodoList, {
    bool callBackup = true,
  }) async {
    if (name.trim() == '') return;
    var horaStr = datetimeToString(DateTime.now());
    var hora = stringToDateTime(horaStr);
    var list = MyListCompanion(
      name: Value(name),
      position: Value(await getNewListPosition()),
      lastModified: Value(datetimeToString(DateTime.now())),
      todoList: Value(isTodoList),
    );
    await _db.into(_db.myList).insert(list);
    await addMaxListId();

    if (callBackup) Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> printLists() async {
    var lists = await _db.select(_db.myList).get();
    for (var l in lists) {
      debugPrint("lista: ${l.name} position= ${l.position} id=${l.id}");
    }
  }

  static Future<TodoElementData> getTodoItem(int id) async {
    var result = await (_db.select(
      _db.todoElement,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    return result;
  }

  static Future<MyListData> getList(int id) async {
    var result = await (_db.select(
      _db.myList,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    return result;
  }

  static Future<int> getListByName(String name) async {
    var result = await (_db.select(
      _db.myList,
    )..where((tbl) => tbl.name.equals(name))).getSingle();
    return result.id;
  }

  static Future<MyElementData> getElement(int id) async {
    var result = await (_db.select(
      _db.myElement,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    return result;
  }

  static Future<TaskData> getTask(int id) async {
    var result = await (_db.select(
      _db.task,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    return result;
  }

  static Future<MySublistData> getSublist(int id) async {
    var result = await (_db.select(
      _db.mySublist,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    return result;
  }

  static Future<String> getListPosition(int id) async {
    var list = await getList(id);
    return list.position;
  }

  static Future<void> changeListName(String name, int id) async {
    await (_db.update(_db.myList)..where((tbl) => tbl.id.equals(id))).write(
      MyListCompanion(
        name: Value(name),
        lastModified: Value(datetimeToString(DateTime.now())),
      ),
    );
    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> changeElementName(
    String name,
    int id,
    bool isItem,
    String notes,
  ) async {
    if (isItem) {
      await (_db.update(
        _db.myElement,
      )..where((tbl) => tbl.id.equals(id))).write(
        MyElementCompanion(
          name: Value(name),
          notes: Value(notes),
          lastModified: Value(datetimeToString(DateTime.now())),
        ),
      );
    } else {
      await (_db.update(
        _db.mySublist,
      )..where((tbl) => tbl.id.equals(id))).write(
        MySublistCompanion(
          name: Value(name),
          notes: Value(notes),
          lastModified: Value(datetimeToString(DateTime.now())),
        ),
      );
    }
    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> changeTodoItem(String text, String notes, int id) async {
    await (_db.update(
      _db.todoElement,
    )..where((tbl) => tbl.id.equals(id))).write(
      TodoElementCompanion(
        name: Value(text),
        notes: Value(notes),
        lastModified: Value(datetimeToString(DateTime.now())),
      ),
    );
    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> setListPosition(String position, int id) async {
    await (_db.update(_db.myList)..where((tbl) => tbl.id.equals(id))).write(
      MyListCompanion(
        position: Value(position),
        lastModified: Value(datetimeToString(DateTime.now())),
      ),
    );
    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> deleteItem({required int id}) async {
    await (_db.delete(_db.myElement)..where((tbl) => tbl.id.equals(id))).go();

    Backup.setBackupNeedAndTryBackup();
  }

  /*static Future<void> deleteSublist(int id) async {
    
    await (_db.delete(_db.mySublist)..where((tbl) => tbl.id.equals(id))).go();
    
    Backup.setBackupNeedAndTryBackup();
  }*/
  static Future<void> deleteTask({required int taskId}) async {
    await (_db.delete(_db.task)..where((tbl) => tbl.id.equals(taskId))).go();
    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> deleteTodoItem({required int id}) async {
    await (_db.delete(_db.todoElement)..where((tbl) => tbl.id.equals(id))).go();
    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> deleteSublist(int id) async {
    await (_db.delete(_db.mySublist)..where((tbl) => tbl.id.equals(id))).go();
    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> deleteList(int id) async {
    await (_db.delete(_db.myList)..where((tbl) => tbl.id.equals(id))).go();
    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> changeElementIsChecked(bool value, int id) async {
    await (_db.update(_db.myElement)..where((tbl) => tbl.id.equals(id))).write(
      MyElementCompanion(
        isChecked: Value(value),
        lastModified: Value(datetimeToString(DateTime.now())),
      ),
    );
  }

  static Future<void> changeElementIsChecked2(
    bool value,
    int id, {
    int? taskIdRelated,
    int? todoitemIdRelated,
  }) async {
    _db.transaction(() async {
      if (taskIdRelated != null) {
        var taskData = await (_db.select(
          _db.task,
        )..where((tbl) => tbl.id.equals(taskIdRelated))).getSingle();
        var startingDay = stringToDateTime(taskData.startingDay)!;
        var date = (DateTime.now().isBefore(startingDay))
            ? startingDay
            : DateTime.now();
        var taskType = taskData.repeatType;
        String checkDays;
        if (taskType == 0 && value == false) {
          checkDays = "";
        } else if (taskType == 0 && value == true) {
          checkDays = listOfDatesToString([startingDay]);
        } else {
          checkDays = taskData.checkDays;
        }

        var taskUpdate = TaskCompanion(
          checkDays: Value(checkDays),
          finished: Value(value),
          finishDay: value ? Value(datetimeToString(date)) : const Value(null),
          lastModified: Value(datetimeToString(DateTime.now())),
        );
        await (_db.update(
          _db.task,
        )..where((tbl) => tbl.id.equals(taskIdRelated))).write(taskUpdate);
      }
      if (todoitemIdRelated != null) {
        var todoItemUpdate = TodoElementCompanion(
          isChecked: Value(value),
          lastModified: Value(datetimeToString(DateTime.now())),
        );
        await (_db.update(_db.todoElement)
              ..where((tbl) => tbl.id.equals(todoitemIdRelated)))
            .write(todoItemUpdate);
      }
      await changeElementIsChecked(value, id);
    });
    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> changetodoItemIsChecked(
    bool value,
    int id, {
    int? projectId,
  }) async {
    _db.transaction(() async {
      await (_db.update(
        _db.todoElement,
      )..where((tbl) => tbl.id.equals(id))).write(
        TodoElementCompanion(
          isChecked: Value(value),
          lastModified: Value(datetimeToString(DateTime.now())),
        ),
      );
      if (projectId != null) {
        await changeElementIsChecked(value, projectId);
      }
    });

    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> changeShowAll(bool value, int id) async {
    await (_db.update(_db.myList)..where((tbl) => tbl.id.equals(id))).write(
      MyListCompanion(
        showAll: Value(value),
        lastModified: Value(datetimeToString(DateTime.now())),
      ),
    );
    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> changeSettingsShowAll(bool value) async {
    await (_db.update(_db.dbSettings)..where((tbl) => tbl.id.equals(1))).write(
      DbSettingsCompanion(plannerShowAll: Value(value)),
    );

    Backup.setBackupNeedAndTryBackup();
  }

  static Future<void> changeIsShrinked(bool value, int id) async {
    await (_db.update(_db.mySublist)..where((tbl) => tbl.id.equals(id))).write(
      MySublistCompanion(
        isShrinked: Value(value),
        lastModified: Value(datetimeToString(DateTime.now())),
      ),
    );
    Backup.setBackupNeedAndTryBackup();
  }

  static Future<String> getTodoElementPosition(int id) async {
    /*var result = await (_db.select(_db.myElement)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();*/
    var result = await (_db.select(
      _db.todoElement,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    return result.position;
  }
}
