import 'package:mockito/mockito.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_gtd_manager_2/database/database.dart';
import 'package:my_gtd_manager_2/firebase/backup.dart';
import 'package:my_gtd_manager_2/firebase_options.dart';
import 'package:my_gtd_manager_2/main.dart';

//comment code //107

int listId = 0;
int elementId = 0;

abstract class NetworkConnectivity {
  Future<bool> isConnectedToInternet();
}

// Implement the interface using connectivity_plus
class MockConnectivity extends Mock implements Connectivity {}

class TextAndDeepth {
  String text;
  int deepth;
  bool isChecked;
  bool hasNotes;
  bool hasCheck;
  bool isSublist;
  TextAndDeepth(
    this.text,
    this.deepth, {
    this.isChecked = false,
    this.isSublist = false,
    this.hasNotes = false,
    this.hasCheck = false,
  });
}

class TextWithPos {
  String text;
  double pos;
  TextWithPos(this.text, this.pos);
}

class List2 {
  String name;
  bool isDragging = true;
  late int id;
  bool onlyFav = false;
  bool shollAll = false;
  late String position;
  List<dynamic> elements = [];
  List2(this.name) {
    listId++;
    id = listId;
    position = listId.toString();
  }
}

class Invisible {
  String parentName;
  Invisible(this.parentName);
}

class Element2 {
  late int id;
  String name;
  late String position;
  int? listParent;
  int? sublistParent;
  bool hasListParent;
  bool isFav = false;
  bool isChecked = false;
  bool isShrinked = false;
  bool isItem;
  List<Element2> elements = [];
  Element2(this.name, this.isItem, this.hasListParent) {
    elementId++;
    id = elementId;
    position = elementId.toString();
  }
}

Future<void> createList(WidgetTester tester, String text) async {
  var addButton = find.byKey(const Key('addListButton'));
  expect(addButton, findsOneWidget);

  await tester.tap(addButton);

  await tester.pump(const Duration(milliseconds: 100));
  var listTextField = find.byKey(const Key("nameInput"));
  expect(listTextField, findsOneWidget);

  await tester.enterText(listTextField, text);
  var saveButton = find.byKey(const Key("SaveButton1"));
  expect(saveButton, findsOneWidget);
  await tester.tap(saveButton);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 500));
}

Future<void> insertItem(WidgetTester tester, String text) async {
  var textInput = find.byKey(const Key("inputList"));
  await typeInFinderWithEnter(tester, textInput, text);
}

Future<void> insertTodoItem2(
  WidgetTester tester,
  int index,
  String listName,
) async {
  await tapInWidget(tester, "PopUpIcon $index");
  await tapInWidget(tester, "InsertTodoItem2");
  await tapInText(tester, "Inbox");
  await tapInText(tester, listName);
  /*var nameInputFinder = find.byKey(const Key("nameInput"));
  await typeInFinder(tester, nameInputFinder, name);*/
  await tapInWidget(tester, "SaveButton1");
}

Future<void> seeRelatedTask(WidgetTester tester, int index) async {
  //seeRelatedTodoItem
  await tapInWidget(tester, "PopUpIcon $index");
  await tapInWidget(tester, "seeRelatedTask");
  var finder = find.text("Change Task");
  expect(finder, findsOneWidget);
  await tapInText(tester, "Cancel");
}

Future<void> seeRelatedTodoItem(WidgetTester tester, int index) async {
  //seeRelatedTodoItem
  await tapInWidget(tester, "PopUpIcon $index");
  await tapInWidget(tester, "seeRelatedTodoItem");
  var finder = find.text("Change Item");
  expect(finder, findsOneWidget);
  await tapInText(tester, "Cancel");
}

Future<void> insertElement(
  WidgetTester tester,
  bool haslistParent,
  bool isItem,
  String text, {
  int? parentId,
}) async {
  assert(
    (haslistParent && parentId == null) || (!haslistParent && parentId != null),
  );
  if (haslistParent) {
    Finder ckButton;
    if (isItem) {
      ckButton = find.byKey(const Key("0 L"));
    } else {
      ckButton = find.byKey(const Key("1 L"));
    }
    expect(ckButton, findsOneWidget);
    await tester.tap(ckButton);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 800));
    //debugPrint("Clicou no checkButton");
    var textInput = find.byKey(const Key("inputList"));
    expect(textInput, findsOneWidget);
    //debugPrint("Achou o input");
    await tester.tap(textInput);
    await tester.enterText(textInput, text);
    await tester.pump(const Duration(milliseconds: 500));
    var textOnTextfield = tester.widget<TextField>(textInput).controller!.text;

    //debugPrint("Digitou o texto");
    expect(textOnTextfield, equals(text));
    await tester.tap(textInput);
    //debugPrint("clicou  no input");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    //debugPrint("Apertou Enter");
  } else {
    Finder plusButton;
    await scroll(tester, 3000, true);
    plusButton = find.byKey(Key("$parentId +"));
    for (int i = 0; i < 10; i++) {
      plusButton = find.byKey(Key("$parentId +"));

      try {
        expect(plusButton, findsOneWidget);

        break;
      } catch (e) {
        await scroll(tester, 400, false);
      }
    }
    //await scroll(tester, 150, false);
    expect(plusButton, findsOneWidget);
    try {
      await tester.tap(plusButton);
    } catch (e) {
      await scroll(tester, 400, false);
      await tester.tap(plusButton);
    }

    await tester.pumpAndSettle();
    Finder ckButton;
    if (isItem) {
      ckButton = find.byKey(const Key("0 SL"));
    } else {
      ckButton = find.byKey(const Key("1 SL"));
    }
    await tester.tap(ckButton);
    var textInput = find.byKey(const Key("inputSublist"));
    expect(textInput, findsOneWidget);
    await tester.tap(textInput);
    await tester.enterText(textInput, text);
    var saveButton = find.byKey(const Key("SaveButton1"));
    expect(saveButton, findsOneWidget);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();
  }

  await tester.pumpAndSettle();
  //var f = find.byKey(Key(text));
  //expect(f, findsOneWidget);
  debugPrint("Inseriu elemento $text");
}

bool compareLists(MyListData a, MyListData b) {
  return a.id == b.id &&
      a.name == b.name &&
      //a.isDragging == b.isDragging &&
      a.showAll == b.showAll &&
      a.lastModified == b.lastModified &&
      a.position == b.position &&
      a.todoList == b.todoList;
}

bool compareSublists(MySublistData a, MySublistData b) {
  return a.ancestorId == b.ancestorId &&
      a.id == b.id &&
      a.name == b.name &&
      a.lastModified == b.lastModified &&
      a.position == b.position &&
      a.hasListParent == b.hasListParent &&
      a.listParent == b.listParent &&
      a.sublistParent == b.sublistParent &&
      a.isShrinked == b.isShrinked &&
      a.notes == b.notes;
}

bool compareItems(MyElementData a, MyElementData b) {
  return a.ancestorId == b.ancestorId &&
      a.id == b.id &&
      a.name == b.name &&
      a.lastModified == b.lastModified &&
      a.position == b.position &&
      a.hasListParent == b.hasListParent &&
      a.listParent == b.listParent &&
      a.sublistParent == b.sublistParent &&
      a.isChecked == b.isChecked &&
      a.taskIdRelated == b.taskIdRelated &&
      a.todoitemIdRelated == b.todoitemIdRelated &&
      a.notes == b.notes;
}

bool compareTodoItems(TodoElementData a, TodoElementData b) {
  return (a.id == b.id &&
      a.name == b.name &&
      a.lastModified == b.lastModified &&
      a.position == b.position &&
      a.listParent == b.listParent &&
      a.isChecked == b.isChecked &&
      a.relatedElementId == b.relatedElementId &&
      a.notes == b.notes);
}

void printBackup(BackupSettings a) {
  debugPrint('''
  maxElementId:${a.maxElementId}
  maxListId:${a.maxListId}
  maxTodoItemId:${a.maxTodoItemId}
  maxTodoListId:${a.maxTodoListId}
  lastBackup:${a.lastBackup}
''');
}

bool compareBackupSettings(BackupSettings a, BackupSettings b) {
  printBackup(a);
  printBackup(b);
  return a.maxElementId == b.maxElementId &&
      a.maxListId == b.maxListId &&
      a.maxTodoItemId == b.maxTodoItemId &&
      a.maxTodoListId == b.maxTodoListId &&
      a.lastBackup == b.lastBackup;
}

Future<void> createLists(WidgetTester tester) async {
  await createList(tester, "L6");
  await createList(tester, "L5");
  await createList(tester, "L4");
  await createList(tester, "L3");
  await createList(tester, "L2");
  await createList(tester, "L1");
}

double getBottomPosition(Finder f, WidgetTester tester) {
  Rect widgetRect = tester.getRect(f);
  var widgetPsosition = widgetRect.bottomLeft;
  return widgetPsosition.dy;
}

double getTopPosition(Finder f, WidgetTester tester) {
  Rect widgetRect = tester.getRect(f);
  var widgetPsosition = widgetRect.topLeft;
  return widgetPsosition.dy;
}

Offset getPosition(
  WidgetTester tester,
  int index,
  double variance, {
  bool isHome = false,
}) {
  var widget = find.byKey(
    Key((isHome) ? "$index home" : "$index"),
    skipOffstage: false,
  );

  var pos = tester.getTopLeft(widget);

  var dx = pos.dx;

  return Offset(dx, pos.dy + variance);
}

Key getKeyByPos(int pos, {isHome = false}) {
  return (isHome) ? Key("$pos home") : Key(pos.toString());
}

String getKeyByName(String name, int pos, {bool isChecked = false}) {
  var keyName = "$name $pos";
  if (isChecked) keyName += " ck";
  return keyName;
}

Future<void> chechMainList() async {}
Future<void> checkTasks(List<String> list, WidgetTester tester) async {
  double posCurrentWidget, posLastWidget;

  debugPrint("CheckTasks");
  var firstWidget = find.byKey(Key("${list[0]} 0"));
  expect(firstWidget, findsOneWidget);
  posCurrentWidget = tester.getTopLeft(firstWidget).dy;
  debugPrint("index: 0");
  var variance = 0;

  for (int index = 1; index < list.length; index++) {
    posLastWidget = posCurrentWidget;
    debugPrint("index: $index");

    var lastWidget = find.byKey(Key("${list[index]} $index"));
    try {
      expect(lastWidget, findsOneWidget);
    } catch (e) {
      await scroll(tester, 250, false);
      variance += 250;
      lastWidget = find.byKey(Key("${list[index]} $index"));
      expect(lastWidget, findsOneWidget);
    }
    posCurrentWidget = tester.getTopLeft(lastWidget).dy + variance;
    expect(posCurrentWidget, greaterThan(posLastWidget));
  }
}

checkIcons(List<TextAndDeepth> list, int index) {
  if (list[index].hasCheck) {
    var key1Name = "ckIcon $index";
    var finder1 = find.byKey(Key(key1Name), skipOffstage: false);
    expect(finder1, findsOneWidget);
  }
  if (list[index].hasNotes) {
    var key2Name = "notesIcon $index";
    var finder2 = find.byKey(Key(key2Name), skipOffstage: false);
    expect(finder2, findsOneWidget);
  }
}

Future<void> checkList(
  List<TextAndDeepth> list,
  WidgetTester tester, {
  isHome = false,
  isPlanner = false,
}) async {
  var keyName = getKeyByName(list[0].text, 0, isChecked: list[0].isChecked);
  await scroll(tester, 3000, true);

  Offset posCurrentWidget, posLastWidget;
  double variance = 0;
  debugPrint("CheckList");
  var firstWidget = find.byKey(Key(keyName), skipOffstage: false);

  expect(firstWidget, findsOneWidget);
  checkIcons(list, 0);
  posCurrentWidget = getPosition(tester, 0, variance, isHome: isHome);

  debugPrint("index: 0");
  debugPrint("text:${list[0].text}");
  //107debugPrint("x: ${posCurrentWidget.dx}, y: ${posCurrentWidget.dy}");

  for (int index = 1; index < list.length; index++) {
    keyName = getKeyByName(
      list[index].text,
      index,
      isChecked: list[index].isChecked,
    );

    posLastWidget = posCurrentWidget;
    debugPrint("index: $index");
    //107debugPrint("text:${list[index].text}");
    Finder listWidget;
    listWidget = find.byKey(Key(keyName), skipOffstage: false);
    try {
      expect(listWidget, findsOneWidget);
      checkIcons(list, index);
    } catch (e) {
      variance += 250;
      await scroll(tester, 250, false);
      listWidget = find.byKey(Key(keyName), skipOffstage: false);
      expect(listWidget, findsOneWidget);
      checkIcons(list, index);
    }
    posCurrentWidget = getPosition(tester, index, variance, isHome: isHome);

    expect(posCurrentWidget.dy, greaterThan(posLastWidget.dy));
    if (!isPlanner) {
      if (list[index].deepth == list[index - 1].deepth) {
        expect(posCurrentWidget.dx, equals(posLastWidget.dx));
      } else if (list[index].deepth > list[index - 1].deepth) {
        expect(posCurrentWidget.dx, greaterThan(posLastWidget.dx));
      } else {
        expect(posCurrentWidget.dx, lessThan(posLastWidget.dx));
      }
    }
  }
  await scroll(tester, 6000, true);
}

Future<void> checkLists(List<String> lists, WidgetTester tester) async {
  List<TextAndDeepth> newList = lists
      .map((list) => TextAndDeepth(list, 0))
      .toList();
  await checkList(newList, tester, isHome: true);
}

Future<void> checkItems(List<String> lists, WidgetTester tester) async {
  List<TextAndDeepth> newList = lists
      .map((list) => TextAndDeepth(list, 0))
      .toList();
  await checkList(newList, tester, isHome: false);
}

Future<void> tapInWidget(
  WidgetTester tester,
  String keyLabel, {
  bool hasScroll = false,
}) async {
  if (hasScroll) await scroll(tester, 3000, true);
  var button = find.byKey(Key(keyLabel));
  var error = true;
  for (int i = 0; i <= 10; i++) {
    try {
      expect(button, findsOneWidget);
      await tester.tap(button);
      error = false;
      break;
    } catch (e) {
      if (hasScroll) {
        await scroll(tester, 400, false);
      } else {
        rethrow;
      }
    }
    button = find.byKey(Key(keyLabel));
  }
  if (error) throw Exception("Widget not Found");
  await tester.pumpAndSettle();
}

Future<void> dragList(WidgetTester tester, double pixels) async {
  Offset initialPosition, finalPosition;
  if (pixels > 0) {
    initialPosition = const Offset(200, 700);
    finalPosition = Offset(200, 700 - pixels);
  } else {
    initialPosition = const Offset(200, 2500);
    finalPosition = Offset(200, 700 + pixels);
  }

  final TestGesture gesture = await tester.startGesture(
    initialPosition,
    kind: PointerDeviceKind.touch,
  );
  await gesture.moveTo(finalPosition, timeStamp: const Duration(seconds: 3));
}

Future<void> scroll(
  WidgetTester tester,
  double value,
  bool up, {
  String keyName = "dragging List",
}) async {
  //dragging List
  var listviewFinder = find.byKey(Key(keyName));
  expect(listviewFinder, findsOneWidget);
  if (up) {
    await tester.drag(listviewFinder, Offset(0, value));
  } else {
    await tester.drag(listviewFinder, Offset(0, -value));
  }
  await tester.pump(const Duration(seconds: 1));
}

Future<void> mySwap(WidgetTester tester) async {
  var initialPosition = const Offset(300, 217);
  var finalPosition = const Offset(300, 466);
  final TestGesture gesture = await tester.startGesture(
    initialPosition,
    kind: PointerDeviceKind.touch,
  );
  await tester.pump(const Duration(milliseconds: 2000));
  await gesture.moveTo(finalPosition, timeStamp: const Duration(seconds: 5));
  await gesture.up();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 400));
}

Future<void> insertAtBottom(
  WidgetTester tester,
  bool isItem,
  String text,
) async {
  await insertElement(tester, true, isItem, text);
  await scroll(tester, 2000, true);
  var cont = -1;
  var continuar = true;
  while (continuar) {
    cont++;
    final realItem = find.byKey(Key("$cont element"));

    try {
      expect(realItem, findsOneWidget);
    } catch (e) {
      cont--;
      continuar = false;
    }
  }
  final firstItem = find.byKey(const Key("0 element"));
  var firstItemPos = tester.getCenter(firstItem);
  final lastItem = find.byKey(Key("$cont element"));
  var lastItemPos = tester.getBottomLeft(lastItem);
  var finalPos = Offset(firstItemPos.dx, lastItemPos.dy);
  final TestGesture gesture = await tester.startGesture(
    firstItemPos,
    kind: PointerDeviceKind.touch,
  );
  debugPrint("Movendo");
  await tester.pump(const Duration(milliseconds: 2000));
  await gesture.moveTo(finalPos, timeStamp: const Duration(seconds: 5));
  for (int i = 0; i < 7; i++) {
    await tester.pumpAndSettle(const Duration(milliseconds: 600));
  }
  await gesture.up();
  debugPrint("moveu");
  await tester.pumpAndSettle();
}

/*Future<void> tapInElement(WidgetTester tester, int index) async {
  final element = find.byKey(Key("$index element"));
  expect(element, findsOneWidget);
  Offset position = tester.getCenter(element);
  await tester.tapAt(position);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
}*/

Future<void> checkDropdownsMenu({
  required WidgetTester tester,
  required Map<String, List<String>> databaseStructure,
  required int index,
  required String currentList,
  required String currentSublist,
}) async {
  await tapInWidget(tester, "$index", hasScroll: true);
  await tester.pumpAndSettle();
  expect(find.byKey(Key("$currentList dp")), findsOneWidget);
  expect(find.byKey(Key("$currentSublist dp")), findsOneWidget);
  var dropdownMenu1 = find.byKey(const Key("dropdown1"));
  var dropdownPos1 = tester.getCenter(dropdownMenu1);
  await tester.tap(dropdownMenu1);
  await tester.pumpAndSettle();
  var lists = databaseStructure.keys;
  double currentHeight = 0;

  for (var item in lists) {
    var element = find.byKey(Key("$item dp"));
    expect(element, findsWidgets);
    var height = tester.getRect(element.last).top;

    expect(height, greaterThan(currentHeight));
    currentHeight = height;
  }
  await tester.tapAt(dropdownPos1);
  await tester.pumpAndSettle();
  var dropdownMenu2 = find.byKey(const Key("dropdown2"));
  var dropdownPos2 = tester.getCenter(dropdownMenu2);
  var currentSublistList = databaseStructure[currentList]!;
  await tester.tap(dropdownMenu2);
  await tester.pumpAndSettle();

  currentHeight = 0;
  for (var item in currentSublistList) {
    var element = find.byKey(Key("$item dp"));
    expect(element, findsWidgets);
    var height = tester.getRect(element.last).top;

    expect(height, greaterThan(currentHeight));
    currentHeight = height;
  }
  await tester.tapAt(dropdownPos2);
  await tester.pumpAndSettle();
  for (var list in databaseStructure.keys) {
    if (list == currentList) continue;
    await changeDropdownMenu(tester, list, "dropdown1");
    var sublists = databaseStructure[list]!;
    await tester.tap(dropdownMenu2);
    await tester.pumpAndSettle();
    currentHeight = 0;
    for (var item in sublists) {
      var element = find.byKey(Key("$item dp"));
      expect(element, findsWidgets);
      var height = tester.getRect(element.last).top;

      expect(height, greaterThan(currentHeight));
      currentHeight = height;
    }
    await tester.tapAt(dropdownPos2);
    await tester.pumpAndSettle();
  }
  await tester.tap(find.byKey(const Key("CancelButton1")));
  await tester.pumpAndSettle();
}

Future<void> changeDropdownMenu(
  WidgetTester tester,
  String newOption,
  String dropdownMenuKey,
) async {
  var dropdownMenu = find.byKey(Key(dropdownMenuKey));

  await tester.tap(dropdownMenu);
  await tester.pumpAndSettle();
  var finder2 = find.byKey(Key("$newOption dp"));
  expect(finder2, findsWidgets);
  await tester.tap(finder2.last, warnIfMissed: false);
  await tester.pumpAndSettle();
}

Future<void> swapItems(
  WidgetTester tester,
  int index1,
  int index2, {
  bool isHome = false,
}) async {
  //await swapItems(tester, 6, 3);
  Offset secondItemPos, firstItemPos;

  final key1 = getKeyByPos(index1, isHome: isHome);

  final key2 = getKeyByPos(index2, isHome: isHome);

  var firstItem = find.byKey(key1, skipOffstage: false);

  expect(firstItem, findsOneWidget);
  firstItemPos = tester.getCenter(firstItem);

  var down = index2 > index1;

  var secondItem = find.byKey(key2, skipOffstage: false);

  expect(secondItem, findsOneWidget);

  if (down) {
    secondItemPos = tester.getTopLeft(secondItem);
  } else {
    secondItemPos = tester.getBottomLeft(secondItem);
  }

  var upMoveValue = firstItemPos.dy - secondItemPos.dy;
  if (down) {
    assert(upMoveValue < 0);
    upMoveValue -= 6;
  } else {
    assert(upMoveValue > 0);
    upMoveValue += 6;
  }
  debugPrint("inicial Position:$firstItemPos");
  final TestGesture gesture = await tester.startGesture(
    firstItemPos,
    kind: PointerDeviceKind.touch,
  );
  await tester.pump(const Duration(seconds: 2));
  var finalPos = Offset(firstItemPos.dx, firstItemPos.dy - upMoveValue);
  debugPrint("final Position:$finalPos");
  await gesture.moveTo(finalPos);
  await gesture.up();
  await tester.pumpAndSettle();
}

Future<void> checkItem(WidgetTester tester, int index) async {
  await scroll(tester, 3000, true);
  Finder ckButon = find.byKey(Key("$index cb"));
  for (int i = 0; i < 10; i++) {
    ckButon = find.byKey(Key("$index cb"));

    try {
      expect(ckButon, findsOneWidget);
      break;
    } catch (e) {
      await scroll(tester, 400, false);
    }
  }
  expect(ckButon, findsOneWidget);

  await tester.tap(ckButon);

  await tester.pumpAndSettle();
}

Future<void> expandOrCompress(WidgetTester tester, int sublistId) async {
  await scroll(tester, 3000, true);
  Finder button = find.byKey(Key("$sublistId -"));
  for (int i = 0; i < 10; i++) {
    try {
      button = find.byKey(Key("$sublistId -"));
      expect(button, findsOneWidget);
    } catch (e) {
      await scroll(tester, 400, false);
    }
  }

  await tester.tap(button);
  await tester.pumpAndSettle();
}

Future<void> checkShowAll(WidgetTester tester) async {
  var ckButon = find.byKey(const Key("showall cb"));
  expect(ckButon, findsOneWidget);
  await tester.tap(ckButon);
  await tester.pumpAndSettle();
}

Future<void> checkOnlyFav(WidgetTester tester) async {
  var ckButon = find.byKey(const Key("fav checkbutton"));
  expect(ckButon, findsOneWidget);
  await tester.tap(ckButon);
  await tester.pumpAndSettle();
}

Future<void> goBack(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.arrow_back));
  await tester.pumpAndSettle();
}

Future<void> changeTileName1(
  WidgetTester tester,
  int index,
  String newName,
  bool isHome,
) async {
  var keyName = (isHome) ? "$index icon" : "$index";
  await tester.tap(find.byKey(Key(keyName)));
  await tester.pumpAndSettle();
  final textInput = find.byKey(const Key("nameInput"));

  expect(textInput, findsOneWidget);
  await tapInFinder(tester, textInput);
  await tester.enterText(textInput, newName);
  await tester.tap(textInput);
  await tester.pumpAndSettle();
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();
}

Future<void> changeTileName2(
  WidgetTester tester,
  int index,
  String newName,
  bool isHome,
) async {
  var keyName = (isHome) ? "$index icon" : "$index";
  await tester.tap(find.byKey(Key(keyName)));
  await tester.pumpAndSettle();
  final textInput = find.byKey(const Key("nameInput"));
  expect(textInput, findsOneWidget);
  await tapInFinder(tester, textInput);
  await tester.enterText(textInput, newName);
  await tester.pumpAndSettle();
  final button = find.byKey(const Key("SaveButton1"));
  expect(button, findsOneWidget);
  await tester.tap(button);
  await tester.pumpAndSettle();
}

Future<void> dontChangeTile(WidgetTester tester, int index, bool isHome) async {
  var keyName = (isHome) ? "$index icon" : "$index";
  await tester.tap(find.byKey(Key(keyName)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key("CancelButton1")));
  await tester.pumpAndSettle();
}

Future<void> deleteElement(
  WidgetTester tester,
  int index, {
  bool isFolder = false,
  bool checkFInalDelete = false,
}) async {
  Finder tile = find.byKey(Key("$index"));
  await scroll(tester, 3000, true);
  for (int i = 0; i < 10; i++) {
    tile = find.byKey(Key("$index"));

    try {
      expect(tile, findsOneWidget);
      break;
    } catch (e) {
      await scroll(tester, 400, false);
    }
  }
  var pos = tester.getTopLeft(tile).dy;
  if (pos > 600) {
    await scroll(tester, 300, false);
  }

  await tester.tap(tile);
  await tester.pumpAndSettle();
  if (isFolder) {
    await tapInText(tester, "Delete folder");
  } else {
    await tapInText(tester, "Delete item");
  }

  await tester.pumpAndSettle();
  if (checkFInalDelete) {
    await tester.tap(find.byKey(const Key("deleteCheckbox")));
  }
  await tester.tap(find.byKey(const Key("finalDelete")));
  await tester.pumpAndSettle();
}

Future<void> deleteList(WidgetTester tester, int index) async {
  await tester.tap(find.byKey(Key("$index icon")));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key("deleteButton")));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key("finalDelete")));
  await tester.pumpAndSettle();
}

Future<void> moveItem(
  WidgetTester tester,
  int index,
  String newList,
  String newSublist,
) async {
  await tapInWidget(tester, "$index", hasScroll: true);
  await changeDropdownMenu(tester, newList, "dropdown1");
  await changeDropdownMenu(tester, newSublist, "dropdown2");
  await tester.tap(find.byKey(const Key("SaveButton1")));
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}

Future<void> login(WidgetTester tester) async {
  await tapInWidget(tester, "emailField");
  await tester.enterText(
    find.byKey(const Key("emailField")),
    'lucascp2004@yahoo.com.br',
  );
  await tapInWidget(tester, "passwordField");
  await tester.enterText(find.byKey(const Key("passwordField")), '123mudar');
  await tapInWidget(tester, "Log in");
  await tester.pumpAndSettle();
  debugPrint('Pausa 2');
  await Future.delayed(const Duration(seconds: 5));
  await tester.pumpAndSettle();
  debugPrint('fim pausa 2');
  var finish = false;
  while (!finish) {
    try {
      var menu = find.byIcon(Icons.menu);
      expect(menu, findsOneWidget);
      finish = true;
    } catch (e) {
      debugPrint("pausa de 10 segundos");
      await tester.pumpAndSettle(const Duration(seconds: 10));
    }
  }
}

Future<void> startProgramAndlogin(WidgetTester tester) async {
  runApp(const MyApp());
  await tester.pumpAndSettle();
  debugPrint('Pausa 1');
  await Future.delayed(const Duration(seconds: 2));
  await tester.pumpAndSettle();
  await login(tester);
}

Finder findTextFieldByText(WidgetTester tester, String text) {
  bool textFieldPredicate(Widget widget) {
    if (widget is TextField) {
      // Replace 'Your Specific Text' with the text you're looking for
      String inputText = widget.controller?.text ?? '';
      return inputText == text;
    }
    return false;
  }

  return find.byWidgetPredicate(textFieldPredicate);
}

Future<void> fimTeste(String msg) async {
  debugPrint(msg);
  await DatabaseDao.deleteAll(false);
  await Backup.clearFirebase();
}

Future<void> tapInFinder(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> typeInFinder(
  WidgetTester tester,
  Finder finder,
  String text,
) async {
  await tapInFinder(tester, finder);
  await tester.enterText(finder, text);

  await tester.pumpAndSettle();
}

Future<void> typeInFinderWithEnter(
  WidgetTester tester,
  Finder finder,
  String text,
) async {
  await tapInFinder(tester, finder);
  await tester.enterText(finder, text);
  await tester.testTextInput.receiveAction(TextInputAction.done);

  await tester.pumpAndSettle();
}

Future<void> tapInText(WidgetTester tester, String text) async {
  await tester.tap(find.text(text).last);
  await tester.pumpAndSettle();
}

Future<void> changeDate(
  WidgetTester tester,
  DateTime initialDate,
  DateTime date,
  String datePickerKey,
) async {
  await tapInWidget(tester, datePickerKey);
  Finder finder = find.byIcon(Icons.edit_outlined);
  await tapInFinder(tester, finder);
  Finder textFinder = findTextFieldByText(
    tester,
    "${initialDate.month}/${initialDate.day}/${initialDate.year}",
  );
  await tapInFinder(tester, textFinder);
  await typeInFinder(
    tester,
    textFinder,
    "${date.month}/${date.day}/${date.year}",
  );
  await tapInText(tester, "OK");
}

Future<void> changeTime(
  WidgetTester tester,
  TimeOfDay time,
  String timePickerKey,
) async {
  await tapInWidget(tester, timePickerKey);
  int hour;
  if (time.hour >= 12) {
    await tapInText(tester, "PM");
    hour = time.hour - 12;
    if (hour == 0) hour = 12;
  } else {
    await tapInText(tester, "AM");
    hour = time.hour;
    if (hour == 0) hour = 12;
  }

  await tapInText(tester, "00");
  await tester.tap(find.text("00").first);

  await tester.pump(const Duration(milliseconds: 100));
  await tester.tap(find.text("00").first);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  var minuteTextField = findTextFieldByText(tester, "00");
  expect(minuteTextField, findsOneWidget);
  await tapInFinder(tester, minuteTextField);
  await typeInFinder(tester, minuteTextField, time.minute.toString());
  var hourTextField = findTextFieldByText(tester, "8");
  expect(hourTextField, findsOneWidget);
  await tapInFinder(tester, hourTextField);
  await typeInFinder(tester, hourTextField, hour.toString());
  await tapInText(tester, "OK");
}

Future<void> dontChangeList(WidgetTester tester, int index) async {
  var finder = find.byKey(Key("$index icon"));
  await tapInFinder(tester, finder);
  await tapInWidget(tester, "CancelButton1");
}

Future<void> almostDeleteList(WidgetTester tester, int index) async {
  var finder = find.byKey(Key("$index icon"));
  await tapInFinder(tester, finder);
  await tapInWidget(tester, "deleteButton");
  await tapInWidget(tester, "CancelButton2");
  await tapInWidget(tester, "CancelButton1");
}

Future<void> dontChange(WidgetTester tester, String text) async {
  await tapInText(tester, text);
  await tapInWidget(tester, "CancelButton1");
}

Future<void> almostDelete(WidgetTester tester, String text) async {
  await tapInText(tester, text);
  await tapInWidget(tester, "deleteButton");
  await tapInWidget(tester, "CancelButton2");
  await tapInWidget(tester, "CancelButton1");
}

Future<void> chooseItemDropdownMenu(
  WidgetTester tester,
  List<String> menuItems,
  int position, {
  int initialPosition = 0,
}) async {
  if (position != 0) {
    await tapInText(tester, menuItems[initialPosition]);
    var itemFinder = find.descendant(
      of: find.byType(Overlay),
      matching: find.text(menuItems[position]),
    );
    await tester.tap(itemFinder);
    await tester.pumpAndSettle();
  }
}

/*await tapInWidget(tester, "PopUpIcon $index");
  await tapInWidget(tester, "InsertTodoItem2");*/
Future<void> insertTask2({
  required WidgetTester tester,

  required bool flexibleTime,
  required int repeatType,
  required DateTime currentDay,
  required DateTime dateTime,
  required int index,
  dynamic value,
  int? customRepeatType,
  TimeOfDay? startTime,
  TimeOfDay? endTime,
}) async {
  await tapInWidget(tester, "PopUpIcon $index");
  await tapInWidget(tester, "InsertTask2");
  await addTask(
    tester: tester,
    task: "",
    flexibleTime: flexibleTime,
    repeatType: repeatType,
    currentDay: currentDay,
    dateTime: dateTime,
    value: value,
    customRepeatType: customRepeatType,
    startTime: startTime,
    endTime: endTime,
    addTask2: true,
  );
}

Future<void> insertTask1({
  required WidgetTester tester,
  required String task,
  required bool flexibleTime,
  required int repeatType,
  required DateTime currentDay,
  required DateTime dateTime,
  dynamic value,
  int? customRepeatType,
  TimeOfDay? startTime,
  TimeOfDay? endTime,
}) async {
  await tapInWidget(tester, "addListButton");
  debugPrint("clicou addTask");
  await addTask(
    tester: tester,
    task: task,
    flexibleTime: flexibleTime,
    repeatType: repeatType,
    currentDay: currentDay,
    dateTime: dateTime,
    value: value,
    customRepeatType: customRepeatType,
    startTime: startTime,
    endTime: endTime,
  );
}

Future<void> completeTask(WidgetTester tester, String taskName) async {
  await tapInText(tester, taskName);
  await tapInText(tester, "Task completed");
}

Future<void> uncompleteTask(WidgetTester tester, String taskName) async {
  await tapInText(tester, taskName);
  await tapInText(tester, "Reopen Task");
}

Future<void> deleteTask(WidgetTester tester, String taskName) async {
  await tapInText(tester, taskName);
  await tapInWidget(tester, "deleteButton");
  await tapInWidget(tester, "finalDelete");
}

Future<void> addTask({
  required WidgetTester tester,
  required String task,
  required bool flexibleTime,
  required int repeatType,
  required DateTime currentDay,
  required DateTime dateTime,
  bool addTask2 = false,
  dynamic value,
  int? customRepeatType,
  TimeOfDay? startTime,
  TimeOfDay? endTime,
}) async {
  var inputKey = find.byKey(const Key("taskInput"));
  await tapInFinder(tester, inputKey);
  if (!addTask2) await typeInFinderWithEnter(tester, inputKey, task);
  debugPrint("digitou a tarefa");

  if (!(currentDay.day == dateTime.day &&
      currentDay.month == dateTime.month &&
      currentDay.year == dateTime.year)) {
    await changeDate(tester, currentDay, dateTime, "datePicker");
  }

  debugPrint("escolheu a data");
  if (flexibleTime) {
    await tapInWidget(tester, "flexible");
    debugPrint("escolheu horario flexivel");
  } else {
    await changeTime(tester, startTime!, "startTime");

    debugPrint("escolheu horario de inicio");
    if (endTime != null) {
      await changeTime(tester, endTime, "endTime");
      debugPrint("escolheu horario de fim");
    }
  }
  if (repeatType != 0) {
    debugPrint("vai selecionar repeatType");
    var menuItems = [
      "No repeat",
      "Every day",
      "Every week",
      "Every month",
      "Every year",
      "Custom repeat",
    ];
    await chooseItemDropdownMenu(tester, menuItems, repeatType);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    debugPrint("escolheu repeaty type");
    if (repeatType == 5) {
      menuItems = ["day", "week", "month", "year"];
      await chooseItemDropdownMenu(tester, menuItems, customRepeatType!);
      debugPrint("escolheu custom repeat");
      String customInput;
      if (customRepeatType != 1) {
        customInput = "$value";
      } else {
        customInput = (value as String).split('#')[0];
      }
      var repeatInput = find.byKey(const Key("repeatInput"));

      await typeInFinderWithEnter(tester, repeatInput, customInput);
      debugPrint("digitou custom value");
      if (customRepeatType == 1) {
        var weekValue = (value as String).split('#')[1];
        var weekday = currentDay.weekday - 1;
        for (int day = 0; day <= 6; day++) {
          if (day == weekday) {
            debugPrint("nao clicou dia $day pois é o currentDay");
            continue;
          }
          var dayValue = weekValue[day];
          if (dayValue == '1') {
            await tapInWidget(tester, "weekday $day");
            debugPrint("clicou dia $day");
          }
        }
        debugPrint('marcou os dias da semana');
      }
    }
  }
  await tapInWidget(tester, "SaveButton1");
  debugPrint(" clicou saveButton");
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
}

Future<void> plannerToProject(WidgetTester tester, String projectName) async {
  var menu = find.byIcon(Icons.menu);
  await tapInFinder(tester, menu);
  var planner = find.text("Projects");
  await tapInFinder(tester, planner);
  await tapInText(tester, projectName);
}

Future<void> projectToPlanner(WidgetTester tester) async {
  await goBack(tester);
  var menu = find.byIcon(Icons.menu);
  await tapInFinder(tester, menu);
  var finder = find.text("Planner");
  await tapInFinder(tester, finder);
}

Future<void> projectToTodolist(WidgetTester tester, String todolistName) async {
  await goBack(tester);
  var menu = find.byIcon(Icons.menu);
  await tapInFinder(tester, menu);
  var todoLists = find.text("Todo Lists");
  await tapInFinder(tester, todoLists);
  await tapInText(tester, todolistName);
}

Future<void> todolistToProject(WidgetTester tester, String projectName) async {
  await goBack(tester);
  var menu = find.byIcon(Icons.menu);
  await tapInFinder(tester, menu);
  var planner = find.text("Projects");
  await tapInFinder(tester, planner);
  await tapInText(tester, projectName);
}

Future<void> printTasks() async {
  debugPrint("TaskDatabase");
  var taskList = await DatabaseDao.getAllTasks();
  for (var task in taskList) {
    debugPrint(task.toString());
  }
}

var sublistId = 0;
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetController.hitTestWarningShouldBeFatal = true;
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });
  tearDownAll(() async {});

  testWidgets("Login ", (WidgetTester tester) async {
    await startProgramAndlogin(tester);
  });

  /*testWidgets("bug", (WidgetTester tester) async{
    runApp(const MyApp());
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds:2));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 5));
  await tester.pumpAndSettle();
  var menu = find.byIcon(Icons.menu);
  await tapInFinder(tester, menu);
  var planner = find.text("Planner");
  await tapInFinder(tester, planner);
  var today=DateTime(2024,2,2);
  await changeDate(tester, DateTime.now(), today, "chooseDate");
  await insertTask1(
    currentDay: today,
    tester: tester,
    task: "task7",
    flexibleTime:true,
    repeatType:3,
    dateTime: today,
    
  );
  debugPrint("task7 finish");
   await tapInText(tester, "task7");
  var menuItems=[
  "No repeat",
  "Every day",
  "Every week",
  "Every month",
  "Every year",
  "Custom repeat",
  ];
  await chooseItemDropdownMenu(tester, menuItems, 5,initialPosition: 3);
  menuItems = [
    "day",
    "week",
    "month",
    "year",
  ];
  await scroll(tester, 300, false,keyName: "TaskForm");
  await chooseItemDropdownMenu(tester, menuItems, 2);
  var repeatInput=find.byKey(const Key("repeatInput"));
  await typeInFinder(tester, repeatInput, "2");
  await tapInWidget(tester, "SaveButton1");
  
  });*/

  var tests = [2, 3, 4, 5, 6, 8, 9, 11];

  testWidgets("Test2 test listsView", (WidgetTester tester) async {
    debugPrint("TEST2 STARTED");
    runApp(const MyApp());
    await Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    var menu = find.byIcon(Icons.menu);
    await tapInFinder(tester, menu);
    var projectsMenu = find.byKey(Key("1 md"));
    await tapInFinder(tester, projectsMenu);
    if (tests.firstWhere(
          (test) => (test == 2) || (test == 3) || (test == 4),
          orElse: () => -1,
        ) ==
        -1)
      return;

    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    await createLists(tester);
    if (tests.firstWhere((test) => (test == 2), orElse: () => -1) == -1) return;
    await checkLists(["L1", "L2", "L3", "L4", "L5", "L6"], tester);
    debugPrint("listas criadas");
    await swapItems(tester, 0, 3, isHome: true);
    debugPrint('\n swap1 complete\n');
    await checkLists(["L2", "L3", "L4", "L1", "L5", "L6"], tester);

    await swapItems(tester, 0, 5, isHome: true);
    debugPrint('\n swap2 complete\n');
    await checkLists(["L3", "L4", "L1", "L5", "L6", "L2"], tester);

    await swapItems(tester, 5, 0, isHome: true);
    debugPrint('\n swap3 complete\n');
    await checkLists(["L2", "L3", "L4", "L1", "L5", "L6"], tester);

    await swapItems(tester, 1, 4, isHome: true);
    debugPrint('\n swap complete\n');
    await checkLists(["L2", "L4", "L1", "L5", "L3", "L6"], tester);
    debugPrint('\n swap4 complete\n');
    await swapItems(tester, 2, 4, isHome: true);
    await checkLists(["L2", "L4", "L5", "L3", "L1", "L6"], tester);
    debugPrint('\n swap5 complete\n');
    await swapItems(tester, 4, 5, isHome: true);
    await checkLists(["L2", "L4", "L5", "L3", "L6", "L1"], tester);
    debugPrint('\n swap6 complete\n');
    await swapItems(tester, 1, 0, isHome: true);
    await checkLists(["L4", "L2", "L5", "L3", "L6", "L1"], tester);
    debugPrint('\n swap7 complete\n');
    await changeTileName1(tester, 2, "L5-1", true);
    debugPrint('\n change L5 list name \n');
    await checkLists(["L4", "L2", "L5-1", "L3", "L6", "L1"], tester);
    await changeTileName2(tester, 4, "L6-1", true);
    await checkLists(["L4", "L2", "L5-1", "L3", "L6-1", "L1"], tester);
    await dontChangeList(tester, 3);
    await almostDeleteList(tester, 4);
    await checkLists(["L4", "L2", "L5-1", "L3", "L6-1", "L1"], tester);
    await deleteList(tester, 2);
    await checkLists(["L4", "L2", "L3", "L6-1", "L1"], tester);
  });
  testWidgets("Test3 delete list and sublist", (WidgetTester tester) async {
    debugPrint("TEST3 STARTED");
    runApp(const MyApp());
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    if (tests.firstWhere((test) => (test == 3), orElse: () => -1) == -1) return;
    await tapInText(tester, "L1");

    await insertElement(tester, true, false, "SL1");

    sublistId += 1;
    await insertElement(tester, false, false, "SL2", parentId: sublistId);
    await insertElement(tester, false, true, "1", parentId: sublistId);
    await insertElement(tester, false, true, "2", parentId: sublistId);
    await insertElement(tester, false, true, "3", parentId: sublistId);
    await insertElement(tester, false, true, "4", parentId: sublistId);
    await insertElement(tester, false, true, "5", parentId: sublistId);

    sublistId += 1;

    await insertElement(tester, false, false, "SL3", parentId: sublistId);
    await insertElement(tester, false, true, "1", parentId: sublistId);
    await insertElement(tester, false, true, "2", parentId: sublistId);
    await insertElement(tester, false, true, "3", parentId: sublistId);
    await insertElement(tester, false, true, "4", parentId: sublistId);
    await insertElement(tester, false, true, "5", parentId: sublistId);
    sublistId += 1;

    await insertElement(tester, false, false, "SL4", parentId: sublistId);
    await insertElement(tester, false, true, "1", parentId: sublistId);
    await insertElement(tester, false, true, "2", parentId: sublistId);
    await insertElement(tester, false, true, "3", parentId: sublistId);
    await insertElement(tester, false, true, "4", parentId: sublistId);
    await insertElement(tester, false, true, "5", parentId: sublistId);
    sublistId += 1;

    await insertElement(tester, false, true, "1", parentId: sublistId);
    await insertElement(tester, false, true, "2", parentId: sublistId);
    await insertElement(tester, false, true, "3", parentId: sublistId);
    await insertElement(tester, false, true, "4", parentId: sublistId);
    await insertElement(tester, false, true, "5", parentId: sublistId);

    var elementsLists = [
      TextAndDeepth("SL1", 0), //0
      TextAndDeepth("5", 1), //1
      TextAndDeepth("4", 1), //2
      TextAndDeepth("3", 1), //3
      TextAndDeepth("2", 1), //4
      TextAndDeepth("1", 1), //5
      TextAndDeepth("SL2", 1), //6
      TextAndDeepth("5", 2),
      TextAndDeepth("4", 2),
      TextAndDeepth("3", 2),
      TextAndDeepth("2", 2),
      TextAndDeepth("1", 2),
      TextAndDeepth("SL3", 2),
      TextAndDeepth("5", 3),
      TextAndDeepth("4", 3),
      TextAndDeepth("3", 3),
      TextAndDeepth("2", 3),
      TextAndDeepth("1", 3),
      TextAndDeepth("SL4", 3),
      TextAndDeepth("5", 4),
      TextAndDeepth("4", 4),
      TextAndDeepth("3", 4),
      TextAndDeepth("2", 4),
      TextAndDeepth("1", 4),
    ];
    await checkList(elementsLists, tester);
    await deleteElement(tester, 6, isFolder: true);

    elementsLists = [
      TextAndDeepth("SL1", 0), //0
      TextAndDeepth("5", 1), //1
      TextAndDeepth("4", 1), //2
      TextAndDeepth("3", 1), //3
      TextAndDeepth("2", 1), //4
      TextAndDeepth("1", 1), //5
    ];
    var sublists = await DatabaseDao.getAllSublists();
    var items = await DatabaseDao.getAllItems();
    expect(sublists.length, equals(1));
    expect(items.length, 5);
    await goBack(tester);

    await tapInText(tester, "L2");
    await insertElement(tester, true, false, "SL1");
    sublistId += 1;
    await insertElement(tester, false, false, "SL2", parentId: sublistId);
    await insertElement(tester, false, true, "1", parentId: sublistId);
    await insertElement(tester, false, true, "2", parentId: sublistId);
    await insertElement(tester, false, true, "3", parentId: sublistId);
    await insertElement(tester, false, true, "4", parentId: sublistId);
    await insertElement(tester, false, true, "5", parentId: sublistId);

    sublistId += 1;

    await insertElement(tester, false, false, "SL3", parentId: sublistId);

    await insertElement(tester, false, true, "1", parentId: sublistId);
    await insertElement(tester, false, true, "2", parentId: sublistId);
    await insertElement(tester, false, true, "3", parentId: sublistId);
    await insertElement(tester, false, true, "4", parentId: sublistId);
    await insertElement(tester, false, true, "5", parentId: sublistId);
    sublistId += 1;

    await insertElement(tester, false, false, "SL4", parentId: sublistId);
    await insertElement(tester, false, true, "1", parentId: sublistId);
    await insertElement(tester, false, true, "2", parentId: sublistId);
    await insertElement(tester, false, true, "3", parentId: sublistId);
    await insertElement(tester, false, true, "4", parentId: sublistId);
    await insertElement(tester, false, true, "5", parentId: sublistId);
    sublistId += 1;

    await insertElement(tester, false, true, "1", parentId: sublistId);
    await insertElement(tester, false, true, "2", parentId: sublistId);
    await insertElement(tester, false, true, "3", parentId: sublistId);
    await insertElement(tester, false, true, "4", parentId: sublistId);
    await insertElement(tester, false, true, "5", parentId: sublistId);

    elementsLists = [
      TextAndDeepth("SL1", 0), //0
      TextAndDeepth("5", 1), //1
      TextAndDeepth("4", 1), //2
      TextAndDeepth("3", 1), //3
      TextAndDeepth("2", 1), //4
      TextAndDeepth("1", 1), //5
      TextAndDeepth("SL2", 1), //6
      TextAndDeepth("5", 2),
      TextAndDeepth("4", 2),
      TextAndDeepth("3", 2),
      TextAndDeepth("2", 2),
      TextAndDeepth("1", 2),
      TextAndDeepth("SL3", 2),
      TextAndDeepth("5", 3),
      TextAndDeepth("4", 3),
      TextAndDeepth("3", 3),
      TextAndDeepth("2", 3),
      TextAndDeepth("1", 3),
      TextAndDeepth("SL4", 3),
      TextAndDeepth("5", 4),
      TextAndDeepth("4", 4),
      TextAndDeepth("3", 4),
      TextAndDeepth("2", 4),
      TextAndDeepth("1", 4),
    ];
    await checkList(elementsLists, tester);
    await goBack(tester);
    await deleteList(tester, 1);
    sublists = await DatabaseDao.getAllSublists();
    items = await DatabaseDao.getAllItems();
    expect(sublists.length, equals(1));
    expect(items.length, 5);
    debugPrint('fim delete list and sublists');
  });
  testWidgets('test4 test change elements', (WidgetTester tester) async {
    debugPrint("TEST4 STARTED");
    runApp(const MyApp());
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    if (tests.firstWhere((test) => (test == 4), orElse: () => -1) == -1) return;
    await tapInText(tester, "L3");
    await insertElement(tester, true, false, "SL1");
    sublistId += 1;
    await insertElement(tester, false, false, "SL2", parentId: sublistId);
    await insertElement(tester, false, true, "1", parentId: sublistId);
    await insertElement(tester, false, true, "2", parentId: sublistId);
    await insertElement(tester, false, true, "3", parentId: sublistId);
    await insertElement(tester, false, true, "4", parentId: sublistId);
    await insertElement(tester, false, true, "5", parentId: sublistId);
    sublistId += 1;
    var elementsListsTest4 = [
      TextAndDeepth("SL1", 0),
      TextAndDeepth("5", 1),
      TextAndDeepth("4", 1),
      TextAndDeepth("3", 1),
      TextAndDeepth("2", 1),
      TextAndDeepth("1", 1),
      TextAndDeepth("SL2", 1),
    ];
    await checkList(elementsListsTest4, tester);
    await changeTileName1(tester, 3, "3-1", false);
    await changeTileName2(tester, 4, "2-1", false);
    await changeTileName1(tester, 0, "SL1-1", false);
    await changeTileName2(tester, 6, "SL2-2", false);
    await dontChange(tester, "SL2-2");
    await dontChange(tester, "2-1");
    await almostDelete(tester, "SL2-2");
    await almostDelete(tester, "2-1");
    elementsListsTest4 = [
      TextAndDeepth("SL1-1", 0),
      TextAndDeepth("5", 1),
      TextAndDeepth("4", 1),
      TextAndDeepth("3-1", 1),
      TextAndDeepth("2-1", 1),
      TextAndDeepth("1", 1),
      TextAndDeepth("SL2-2", 1),
    ];
    await checkList(elementsListsTest4, tester);
    await goBack(tester);
  });
  testWidgets('test5 Testing Listview', (WidgetTester tester) async {
    debugPrint("TEST5 STARTED");
    runApp(const MyApp());
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    if (tests.firstWhere((test) => (test == 5), orElse: () => -1) == -1) return;
    await createList(tester, "Lista");
    await tapInWidget(tester, "Lista 0");
    await tester.pumpAndSettle();

    //inserir elementos na lista principal
    await insertElement(tester, true, true, "0");
    await insertElement(tester, true, true, "1");
    await insertElement(tester, true, true, "2");
    await insertElement(tester, true, true, "3");
    await insertElement(tester, true, true, "4");
    await insertElement(tester, true, true, "5");
    await insertElement(tester, true, false, "A");
    await insertElement(tester, true, true, "topo");

    var list1 = [
      TextAndDeepth("topo", 0), //0
      TextAndDeepth("A", 0), //1

      TextAndDeepth("5", 0), //2
      TextAndDeepth("4", 0), //3
      TextAndDeepth("3", 0), //4
      TextAndDeepth("2", 0), //5
      TextAndDeepth("1", 0), //6
      TextAndDeepth("0", 0), //7
    ];
    debugPrint("\n Lista 1\n");
    await checkList(list1, tester);

    sublistId += 1;
    await insertElement(tester, false, true, "6", parentId: sublistId);
    await insertElement(tester, false, true, "7", parentId: sublistId);
    await insertElement(tester, false, false, "B", parentId: sublistId);
    await insertElement(tester, false, true, "8", parentId: sublistId);
    await insertElement(tester, false, true, "9", parentId: sublistId);
    sublistId += 1;
    await insertElement(tester, false, true, "10", parentId: sublistId);
    await insertElement(tester, false, false, "C", parentId: sublistId);
    await insertElement(tester, false, true, "11", parentId: sublistId);
    sublistId += 1;
    await insertElement(tester, false, true, "12", parentId: sublistId);
    await insertElement(tester, false, true, "13", parentId: sublistId);

    var list2 = [
      TextAndDeepth("topo", 0), //0
      TextAndDeepth("A", 0), //1
      TextAndDeepth("9", 1), //5
      TextAndDeepth("8", 1), //6
      TextAndDeepth("B", 1), //7
      TextAndDeepth("11", 2), //8
      TextAndDeepth("C", 2), //9
      TextAndDeepth("13", 3), //10
      TextAndDeepth("12", 3), //11
      TextAndDeepth("10", 2), //12
      TextAndDeepth("7", 1), //13
      TextAndDeepth("6", 1), //14
      TextAndDeepth("5", 0), //2
      TextAndDeepth("4", 0), //3
      TextAndDeepth("3", 0), //4
      TextAndDeepth("2", 0), //5
      TextAndDeepth("1", 0), //6
      TextAndDeepth("0", 0), //7
    ];

    debugPrint("\n Lista 2\n");
    await checkList(list2, tester);

    await insertElement(tester, false, true, "14", parentId: sublistId - 2);

    var list3 = [
      TextAndDeepth("topo", 0), //0
      TextAndDeepth("A", 0), //1
      TextAndDeepth("14", 1), //5
      TextAndDeepth("9", 1), //5
      TextAndDeepth("8", 1), //6
      TextAndDeepth("B", 1), //7
      TextAndDeepth("11", 2), //8
      TextAndDeepth("C", 2), //9
      TextAndDeepth("13", 3), //10
      TextAndDeepth("12", 3), //11
      TextAndDeepth("10", 2), //12
      TextAndDeepth("7", 1), //13
      TextAndDeepth("6", 1), //14
      TextAndDeepth("5", 0), //2
      TextAndDeepth("4", 0), //3
      TextAndDeepth("3", 0), //4
      TextAndDeepth("2", 0), //5
      TextAndDeepth("1", 0), //6
      TextAndDeepth("0", 0), //7
    ];
    debugPrint('\nlista 3\n');
    await checkList(list3, tester);
    await checkItem(tester, 4);
    await checkItem(tester, 3);

    var list4 = [
      TextAndDeepth("topo", 0), //0
      TextAndDeepth("A", 0), //1
      TextAndDeepth("14", 1), //5
      /*TextAndDeepth("9", 1), //5
        TextAndDeepth("8", 1), //6*/
      TextAndDeepth("B", 1), //7
      TextAndDeepth("11", 2), //8
      TextAndDeepth("C", 2), //9
      TextAndDeepth("13", 3), //10
      TextAndDeepth("12", 3), //11
      TextAndDeepth("10", 2), //12
      TextAndDeepth("7", 1), //13
      TextAndDeepth("6", 1), //14
      TextAndDeepth("5", 0), //2
      TextAndDeepth("4", 0), //3
      TextAndDeepth("3", 0), //4
      TextAndDeepth("2", 0), //5
      TextAndDeepth("1", 0), //6
      TextAndDeepth("0", 0), //7
    ];
    debugPrint('\nlista 4\n');
    await checkList(list4, tester);
    await checkShowAll(tester); //true
    var list5 = [
      TextAndDeepth("topo", 0), //0
      TextAndDeepth("A", 0), //1
      TextAndDeepth("14", 1), //2
      TextAndDeepth("9", 1, isChecked: true), //3
      TextAndDeepth("8", 1, isChecked: true), //4
      TextAndDeepth("B", 1), //5
      TextAndDeepth("11", 2), //6
      TextAndDeepth("C", 2), //7
      TextAndDeepth("13", 3), //8
      TextAndDeepth("12", 3), //9
      TextAndDeepth("10", 2), //10
      TextAndDeepth("7", 1), //11
      TextAndDeepth("6", 1), //12
      TextAndDeepth("5", 0), //13
      TextAndDeepth("4", 0), //14
      TextAndDeepth("3", 0), //15
      TextAndDeepth("2", 0), //16
      TextAndDeepth("1", 0), //17
      TextAndDeepth("0", 0), //18
    ];
    debugPrint('\nlista 5\n');
    await checkList(list5, tester);
    await checkItem(tester, 12);
    await checkItem(tester, 11);
    //testando marcar items com o showAll ligado
    var list6 = [
      TextAndDeepth("topo", 0), //0
      TextAndDeepth("A", 0), //1
      TextAndDeepth("14", 1), //2
      TextAndDeepth("9", 1, isChecked: true), //3
      TextAndDeepth("8", 1, isChecked: true), //4
      TextAndDeepth("B", 1), //5
      TextAndDeepth("11", 2), //6
      TextAndDeepth("C", 2), //8
      TextAndDeepth("13", 3), //9
      TextAndDeepth("12", 3), //10
      TextAndDeepth("10", 2), //11
      TextAndDeepth("7", 1, isChecked: true), //12
      TextAndDeepth("6", 1, isChecked: true), //13
      TextAndDeepth("5", 0), //14
      TextAndDeepth("4", 0), //15
      TextAndDeepth("3", 0), //16
      TextAndDeepth("2", 0), //17
      TextAndDeepth("1", 0), //18
      TextAndDeepth("0", 0), //19
    ];
    debugPrint('\n Lista 6 \n');
    await checkList(list6, tester);
    await checkShowAll(tester); //false
    var list7 = [
      TextAndDeepth("topo", 0), //0
      TextAndDeepth("A", 0), //1
      TextAndDeepth("14", 1), //2
      /*TextAndDeepth("9", 1,isChecked: true), //3
      TextAndDeepth("8", 1,isChecked: true), //4*/
      TextAndDeepth("B", 1), //5
      TextAndDeepth("11", 2), //6
      TextAndDeepth("C", 2), //7
      TextAndDeepth("13", 3), //8
      TextAndDeepth("12", 3), //9
      TextAndDeepth("10", 2), //10
      /*TextAndDeepth("7", 1, isChecked: true), //11
      TextAndDeepth("6", 1, isChecked: true), //12*/
      TextAndDeepth("5", 0), //13
      TextAndDeepth("4", 0), //14
      TextAndDeepth("3", 0), //15
      TextAndDeepth("2", 0), //16
      TextAndDeepth("1", 0), //17
      TextAndDeepth("0", 0), //18
    ];

    debugPrint('\n Lista 7 \n');
    await checkList(list7, tester);

    await checkItem(tester, 12);
    await checkItem(tester, 11);
    //TextAndDeepth("15", 1), //6
    var list8 = [
      TextAndDeepth("topo", 0), //0
      TextAndDeepth("A", 0), //1

      TextAndDeepth("14", 1), //2
      /*TextAndDeepth("9", 1,isChecked: true), //3
      TextAndDeepth("8", 1,isChecked: true), //4*/
      TextAndDeepth("B", 1), //5
      TextAndDeepth("11", 2), //6
      TextAndDeepth("C", 2), //8
      TextAndDeepth("13", 3), //9
      TextAndDeepth("12", 3), //10
      TextAndDeepth("10", 2), //11
      /*TextAndDeepth("7", 1, isChecked: true), //12
      TextAndDeepth("6", 1, isChecked: true), //13*/
      TextAndDeepth("5", 0), //14
      TextAndDeepth("4", 0), //15
      /*TextAndDeepth("3", 0), //16
    TextAndDeepth("2", 0), //17*/
      TextAndDeepth("1", 0), //18
      TextAndDeepth("0", 0), //19
    ];
    debugPrint("lista 8");
    await checkList(list8, tester);

    await insertElement(tester, false, true, "15", parentId: sublistId - 2);
    var list9 = [
      TextAndDeepth("topo", 0), //0
      TextAndDeepth("A", 0), //1
      TextAndDeepth("15", 1),
      TextAndDeepth("14", 1), //2
      /*TextAndDeepth("9", 1,isChecked: true), //3
      TextAndDeepth("8", 1,isChecked: true), //4*/
      TextAndDeepth("B", 1), //5
      TextAndDeepth("11", 2), //6
      TextAndDeepth("C", 2), //8
      TextAndDeepth("13", 3), //9
      TextAndDeepth("12", 3), //10
      TextAndDeepth("10", 2), //11
      /*TextAndDeepth("7", 1, isChecked: true), //12
      TextAndDeepth("6", 1, isChecked: true), //13*/
      TextAndDeepth("5", 0), //14
      TextAndDeepth("4", 0), //15
      /*TextAndDeepth("3", 0), //16
    TextAndDeepth("2", 0), //17*/
      TextAndDeepth("1", 0), //18
      TextAndDeepth("0", 0), //19
    ];
    debugPrint('\n Lista 9\n');
    await checkList(list9, tester);
    await checkShowAll(tester); //true
    var list10 = [
      TextAndDeepth("topo", 0), //0
      TextAndDeepth("A", 0), //1
      TextAndDeepth("15", 1), //2
      TextAndDeepth("14", 1), //3
      TextAndDeepth("9", 1, isChecked: true), //4
      TextAndDeepth("8", 1, isChecked: true), //5
      TextAndDeepth("B", 1), //6
      TextAndDeepth("11", 2), //7
      TextAndDeepth("C", 2), //8
      TextAndDeepth("13", 3), //9
      TextAndDeepth("12", 3), //10
      TextAndDeepth("10", 2), //11
      TextAndDeepth("7", 1, isChecked: true), //12
      TextAndDeepth("6", 1, isChecked: true), //13
      TextAndDeepth("5", 0), //14
      TextAndDeepth("4", 0), //15
      TextAndDeepth("3", 0, isChecked: true), //16
      TextAndDeepth("2", 0, isChecked: true), //17
      TextAndDeepth("1", 0), //18
      TextAndDeepth("0", 0), //19
    ];
    debugPrint('\n Lista 10\n');
    await checkList(list10, tester);
    var indexes = [17, 16, 13, 12, 5, 4];
    for (var index in indexes) {
      await deleteElement(tester, index);
    }

    var list11 = [
      TextAndDeepth("topo", 0), //0
      TextAndDeepth("A", 0), //1
      TextAndDeepth("15", 1), //2
      TextAndDeepth("14", 1), //3
      TextAndDeepth("B", 1), //4
      TextAndDeepth("11", 2), //5
      TextAndDeepth("C", 2), //6
      TextAndDeepth("13", 3), //7
      TextAndDeepth("12", 3), //8
      TextAndDeepth("10", 2), //9
      TextAndDeepth("5", 0), //10
      TextAndDeepth("4", 0), //11
      TextAndDeepth("1", 0), //12
      TextAndDeepth("0", 0), //13
    ];
    debugPrint('\n LISTA 11 \n');
    await checkList(list11, tester);

    //indexes=[0,10,11,12,13];
    indexes = [13, 12, 11, 10, 0];
    for (var index in indexes) {
      await deleteElement(tester, index);
    }
    var list12 = [
      TextAndDeepth("A", 0), //1
      TextAndDeepth("15", 1), //2
      TextAndDeepth("14", 1), //3
      TextAndDeepth("B", 1), //4
      TextAndDeepth("11", 2), //5
      TextAndDeepth("C", 2), //6
      TextAndDeepth("13", 3), //7
      TextAndDeepth("12", 3), //8
      TextAndDeepth("10", 2), //9
    ];

    debugPrint('\n LISTA 12 \n');
    await checkList(list12, tester);

    await insertElement(tester, false, true, "16", parentId: sublistId - 2);
    await insertElement(tester, false, true, "17", parentId: sublistId - 2);
    await insertElement(tester, false, false, "D", parentId: sublistId - 2);
    sublistId++;
    await insertElement(tester, false, true, "18", parentId: sublistId);
    await insertElement(tester, false, true, "19", parentId: sublistId);
    await insertElement(tester, false, true, "20", parentId: sublistId);
    var list13 = [
      TextAndDeepth("A", 0), //0
      TextAndDeepth("D", 1), //1
      TextAndDeepth("20", 2), //2
      TextAndDeepth("19", 2), //3
      TextAndDeepth("18", 2), //4
      TextAndDeepth("17", 1), //5
      TextAndDeepth("16", 1), //6
      TextAndDeepth("15", 1), //7
      TextAndDeepth("14", 1), //8
      TextAndDeepth("B", 1), //9
      TextAndDeepth("11", 2), //10
      TextAndDeepth("C", 2), //11
      TextAndDeepth("13", 3), //12
      TextAndDeepth("12", 3), //13
      TextAndDeepth("10", 2), //14
    ];
    debugPrint('Lista13');

    await checkList(list13, tester);
    await checkItem(tester, 13);
    await checkItem(tester, 12);
    await expandOrCompress(tester, sublistId - 2);
    var list14 = [
      TextAndDeepth("A", 0), //0
      TextAndDeepth("D", 1), //1
      TextAndDeepth("20", 2), //2
      TextAndDeepth("19", 2), //3
      TextAndDeepth("18", 2), //4
      TextAndDeepth("17", 1), //5
      TextAndDeepth("16", 1), //6
      TextAndDeepth("15", 1), //7
      TextAndDeepth("14", 1), //8
      TextAndDeepth("B", 1), //9
      /*TextAndDeepth("11", 2), //10s
        TextAndDeepth("C", 2), //11
          TextAndDeepth("13", 3, isChecked: true), //12
          TextAndDeepth("12", 3, isChecked: true), //13
        TextAndDeepth("10", 2), //14*/
    ];
    debugPrint('list 14');
    await checkList(list14, tester);
    await checkShowAll(tester); //false
    await expandOrCompress(tester, sublistId - 2);
    var list15 = [
      TextAndDeepth("A", 0), //0
      TextAndDeepth("D", 1), //1
      TextAndDeepth("20", 2), //2
      TextAndDeepth("19", 2), //3
      TextAndDeepth("18", 2), //4
      TextAndDeepth("17", 1), //5
      TextAndDeepth("16", 1), //6
      TextAndDeepth("15", 1), //7
      TextAndDeepth("14", 1), //8
      TextAndDeepth("B", 1), //9
      TextAndDeepth("11", 2), //10s
      TextAndDeepth("C", 2), //11
      /*TextAndDeepth("13", 3, isChecked: true), //12
          TextAndDeepth("12", 3, isChecked: true), //13*/
      TextAndDeepth("10", 2), //14
    ];
    await checkList(list15, tester);
    debugPrint('list 15');
    await goBack(tester);
  });
  testWidgets('test6 change folder', (WidgetTester tester) async {
    debugPrint("TEST6 STARTED");
    runApp(const MyApp());

    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    if (tests.firstWhere((test) => (test == 6), orElse: () => -1) == -1) return;
    await createList(tester, "List2");
    await tapInWidget(tester, "List2 0");
    await insertElement(tester, true, false, "sublist3"); //1
    sublistId++;
    await insertElement(tester, true, false, "sublist2"); //2
    sublistId++;
    await insertElement(tester, true, false, "sublist1"); //3
    sublistId++;
    await insertElement(
      tester,
      false,
      false,
      "sublist1-3",
      parentId: sublistId,
    ); //4
    await insertElement(
      tester,
      false,
      false,
      "sublist1-2",
      parentId: sublistId,
    ); //5
    await insertElement(
      tester,
      false,
      false,
      "sublist1-1",
      parentId: sublistId,
    ); //6
    await insertElement(
      tester,
      false,
      false,
      "sublist2-3",
      parentId: sublistId - 1,
    ); //7
    await insertElement(
      tester,
      false,
      false,
      "sublist2-2",
      parentId: sublistId - 1,
    ); //8
    await insertElement(
      tester,
      false,
      false,
      "sublist2-1",
      parentId: sublistId - 1,
    ); //9
    sublistId += 6;
    await insertElement(
      tester,
      false,
      false,
      "sublist1-3-3",
      parentId: sublistId - 5,
    ); //10
    await insertElement(
      tester,
      false,
      false,
      "sublist1-3-2",
      parentId: sublistId - 5,
    ); //11
    await insertElement(
      tester,
      false,
      false,
      "sublist1-3-1",
      parentId: sublistId - 5,
    ); //12
    sublistId += 3;
    await insertElement(tester, false, true, "3", parentId: sublistId - 2);
    await insertElement(tester, false, true, "2", parentId: sublistId - 2);
    await insertElement(tester, false, true, "1", parentId: sublistId - 2);
    var list1 = [
      TextAndDeepth("sublist1", 0),
      TextAndDeepth("sublist1-1", 1),
      TextAndDeepth("sublist1-2", 1),
      TextAndDeepth("sublist1-3", 1),
      TextAndDeepth("sublist1-3-1", 2),
      TextAndDeepth("sublist1-3-2", 2),
      TextAndDeepth("sublist1-3-3", 2),
      TextAndDeepth("1", 3),
      TextAndDeepth("2", 3),
      TextAndDeepth("3", 3),

      TextAndDeepth("sublist2", 0),
      TextAndDeepth("sublist2-1", 1),
      TextAndDeepth("sublist2-2", 1),
      TextAndDeepth("sublist2-3", 1),
      TextAndDeepth("sublist3", 0),
    ];
    debugPrint("Change1");
    await checkList(list1, tester);
    List<String> list2Sublists = [];
    for (var element in list1) {
      if (element.text.startsWith("sublist")) {
        list2Sublists.add(element.text);
      }
    }
    list2Sublists.insert(0, "No folder");
    await goBack(tester);
    await createList(tester, "List3");
    await tapInWidget(tester, "List3 0");
    await insertElement(tester, true, false, "sublist3");
    sublistId++;
    var cont = 3;
    for (int index = 3; index >= 1; index--) {
      debugPrint("index: $index");
      await insertElement(
        tester,
        false,
        true,
        "$cont-$index",
        parentId: sublistId,
      );
    }
    cont--;
    await insertElement(tester, true, false, "sublist2");
    sublistId++;
    for (int index = 3; index >= 1; index--) {
      await insertElement(
        tester,
        false,
        true,
        "$cont-$index",
        parentId: sublistId,
      );
    }
    cont--;
    await insertElement(tester, true, false, "sublist1");
    sublistId++;
    for (int index = 3; index >= 1; index--) {
      await insertElement(
        tester,
        false,
        true,
        "$cont-$index",
        parentId: sublistId,
      );
    }

    var list2 = [
      TextAndDeepth("sublist1", 0), //0
      TextAndDeepth("1-1", 1), //1
      TextAndDeepth("1-2", 1), //2
      TextAndDeepth("1-3", 1), //3
      TextAndDeepth("sublist2", 0), //4
      TextAndDeepth("2-1", 1), //5
      TextAndDeepth("2-2", 1), //6
      TextAndDeepth("2-3", 1), //7
      TextAndDeepth("sublist3", 0), //8
      TextAndDeepth("3-1", 1), //9
      TextAndDeepth("3-2", 1), //10
      TextAndDeepth("3-3", 1), //11
    ];
    debugPrint("Change2");
    await checkList(list2, tester);
    Map<String, List<String>> sublistsStructure = {
      "List3": ["No folder", "sublist1", "sublist2", "sublist3"],
      "List2": list2Sublists,
    };

    await checkDropdownsMenu(
      tester: tester,
      databaseStructure: sublistsStructure,
      index: 10,
      currentList: "List3",
      currentSublist: "sublist3",
    );
    await moveItem(tester, 11, "List3", "sublist1");
    await moveItem(tester, 11, "List3", "No folder");
    await moveItem(tester, 8, "List3", "sublist2");
    var list3 = [
      TextAndDeepth("3-2", 0), //0
      TextAndDeepth("sublist1", 0), //1
      TextAndDeepth("3-3", 1), //2
      TextAndDeepth("1-1", 1), //3
      TextAndDeepth("1-2", 1), //4
      TextAndDeepth("1-3", 1), //5
      TextAndDeepth("sublist2", 0), //6
      TextAndDeepth("2-1", 1), //7
      TextAndDeepth("2-2", 1), //8
      TextAndDeepth("2-3", 1), //9
      TextAndDeepth("sublist3", 0), //10
      TextAndDeepth("3-1", 1), //11
    ];
    debugPrint("Change3");
    await checkList(list3, tester);
    await moveItem(tester, 11, "List2", "sublist1-3-2");
    await moveItem(tester, 0, "List2", "No folder");
    var list4 = [
      TextAndDeepth("sublist1", 0), //0
      TextAndDeepth("3-3", 1), //1
      TextAndDeepth("1-1", 1), //2
      TextAndDeepth("1-2", 1), //3
      TextAndDeepth("1-3", 1), //4
      TextAndDeepth("sublist2", 0), //5
      TextAndDeepth("2-1", 1), //6
      TextAndDeepth("2-2", 1), //7
      TextAndDeepth("2-3", 1), //8
      TextAndDeepth("sublist3", 0), //9
    ];
    debugPrint("Change4");
    await checkList(list4, tester);
    await insertElement(
      tester,
      false,
      false,
      "sublist1-1",
      parentId: sublistId,
    );
    sublistId++;
    await insertElement(
      tester,
      false,
      false,
      "sublist1-1-1",
      parentId: sublistId,
    );
    sublistId++;
    var list5 = [
      TextAndDeepth("sublist1", 0),
      TextAndDeepth("sublist1-1", 1),
      TextAndDeepth("sublist1-1-1", 2),
      TextAndDeepth("3-3", 1), //1
      TextAndDeepth("1-1", 1), //2
      TextAndDeepth("1-2", 1), //3
      TextAndDeepth("1-3", 1), //4
      TextAndDeepth("sublist2", 0), //5
      TextAndDeepth("2-1", 1), //6
      TextAndDeepth("2-2", 1), //7
      TextAndDeepth("2-3", 1), //8
      TextAndDeepth("sublist3", 0), //9
    ];
    debugPrint("Change5");
    await checkList(list5, tester);

    await goBack(tester);
    await tapInWidget(tester, "List2 1");
    var list6 = [
      TextAndDeepth("3-2", 0), //0
      TextAndDeepth("sublist1", 0), //1
      TextAndDeepth("sublist1-1", 1), //2
      TextAndDeepth("sublist1-2", 1), //3

      TextAndDeepth("sublist1-3", 1), //4
      TextAndDeepth("sublist1-3-1", 2), //5
      TextAndDeepth("sublist1-3-2", 2), //6
      TextAndDeepth("3-1", 3), //7
      TextAndDeepth("sublist1-3-3", 2), //8
      TextAndDeepth("1", 3),
      TextAndDeepth("2", 3),
      TextAndDeepth("3", 3),

      TextAndDeepth("sublist2", 0),
      TextAndDeepth("sublist2-1", 1),
      TextAndDeepth("sublist2-2", 1),
      TextAndDeepth("sublist2-3", 1),
      TextAndDeepth("sublist3", 0),
    ];
    debugPrint("Change6");
    await checkList(list6, tester);
    await moveItem(tester, 8, "List2", "No folder");
    debugPrint("move list sublist1-3-3 to No Folder");
    var list7 = [
      TextAndDeepth("sublist1-3-3", 0), //0
      TextAndDeepth("1", 1), //1
      TextAndDeepth("2", 1), //2
      TextAndDeepth("3", 1), //3
      TextAndDeepth("3-2", 0), //4
      TextAndDeepth("sublist1", 0), //5
      TextAndDeepth("sublist1-1", 1), //6
      TextAndDeepth("sublist1-2", 1), //7

      TextAndDeepth("sublist1-3", 1), //8
      TextAndDeepth("sublist1-3-1", 2), //
      TextAndDeepth("sublist1-3-2", 2), //
      TextAndDeepth("3-1", 3), //

      TextAndDeepth("sublist2", 0),
      TextAndDeepth("sublist2-1", 1),
      TextAndDeepth("sublist2-2", 1),
      TextAndDeepth("sublist2-3", 1),
      TextAndDeepth("sublist3", 0),
    ];
    debugPrint("Change7");
    await checkList(list7, tester);
    await moveItem(tester, 8, "List2", "sublist2-3");

    debugPrint("move list sublist1-3 to sublist2-3");
    var list8 = [
      TextAndDeepth("sublist1-3-3", 0), //0
      TextAndDeepth("1", 1), //1
      TextAndDeepth("2", 1), //2
      TextAndDeepth("3", 1), //3
      TextAndDeepth("3-2", 0), //4
      TextAndDeepth("sublist1", 0), //5
      TextAndDeepth("sublist1-1", 1), //6
      TextAndDeepth("sublist1-2", 1), //7
      TextAndDeepth("sublist2", 0), //8
      TextAndDeepth("sublist2-1", 1), //9
      TextAndDeepth("sublist2-2", 1), //10
      TextAndDeepth("sublist2-3", 1), //11
      TextAndDeepth("sublist1-3", 2), //8
      TextAndDeepth("sublist1-3-1", 3), //
      TextAndDeepth("sublist1-3-2", 3), //
      TextAndDeepth("3-1", 4), //
      TextAndDeepth("sublist3", 0),
    ];
    debugPrint("Change8");
    await checkList(list8, tester);
    await moveItem(tester, 0, "List3", "No folder");
    var list9 = [
      TextAndDeepth("3-2", 0), //0
      TextAndDeepth("sublist1", 0), //1
      TextAndDeepth("sublist1-1", 1), //2
      TextAndDeepth("sublist1-2", 1), //3
      TextAndDeepth("sublist2", 0), //4
      TextAndDeepth("sublist2-1", 1), //9
      TextAndDeepth("sublist2-2", 1), //10
      TextAndDeepth("sublist2-3", 1), //11
      TextAndDeepth("sublist1-3", 2), //8
      TextAndDeepth("sublist1-3-1", 3), //
      TextAndDeepth("sublist1-3-2", 3), //
      TextAndDeepth("3-1", 4),
      TextAndDeepth("sublist3", 0),
    ];
    debugPrint("Change9");
    await checkList(list9, tester);
    await moveItem(tester, 4, "List3", "sublist1-1-1");
    debugPrint("Lista 10");
    var list10 = [
      /*TextAndDeepth("sublist1-3-3", 0),//0
      TextAndDeepth("1", 1),//1
      TextAndDeepth("2", 1),//2
      TextAndDeepth("3", 1),//3/
      */
      TextAndDeepth("3-2", 0), //0
      TextAndDeepth("sublist1", 0), //1
      TextAndDeepth("sublist1-1", 1), //2
      TextAndDeepth("sublist1-2", 1), //3
      /*TextAndDeepth("sublist2", 0), //4
      TextAndDeepth("sublist2-1", 1), //9
      TextAndDeepth("sublist2-2", 1), //10 
      TextAndDeepth("sublist2-3", 1), //11
        TextAndDeepth("sublist1-3", 2), //8
          TextAndDeepth("sublist1-3-1", 3),//
          TextAndDeepth("sublist1-3-2", 3),//
            TextAndDeepth("3-1", 4), */
      TextAndDeepth("sublist3", 0),
    ];
    debugPrint("Change10");
    await checkList(list10, tester);

    await goBack(tester);
    await tapInWidget(tester, "List3 0");
    var list11 = [
      TextAndDeepth("sublist1-3-3", 0), //0
      TextAndDeepth("1", 1), //1
      TextAndDeepth("2", 1), //2
      TextAndDeepth("3", 1), //3/
      TextAndDeepth("sublist1", 0),
      TextAndDeepth("sublist1-1", 1),
      TextAndDeepth("sublist1-1-1", 2),
      TextAndDeepth("sublist2", 3), //4
      TextAndDeepth("sublist2-1", 4), //9
      TextAndDeepth("sublist2-2", 4), //10
      TextAndDeepth("sublist2-3", 4), //11
      TextAndDeepth("sublist1-3", 5), //8
      TextAndDeepth("sublist1-3-1", 6), //
      TextAndDeepth("sublist1-3-2", 6), //
      TextAndDeepth("3-1", 7),
      TextAndDeepth("3-3", 1), //1
      TextAndDeepth("1-1", 1), //2
      TextAndDeepth("1-2", 1), //3
      TextAndDeepth("1-3", 1), //4
      TextAndDeepth("sublist2", 0), //5
      TextAndDeepth("2-1", 1), //6
      TextAndDeepth("2-2", 1), //7
      TextAndDeepth("2-3", 1), //8
      TextAndDeepth("sublist3", 0), //9
    ];

    debugPrint("Change11");
    await checkList(list11, tester);
    await goBack(tester);
  });
  testWidgets('test7 Related elements', (WidgetTester tester) async {
    debugPrint("TEST7 STARTED");
    runApp(const MyApp());
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    if (tests.firstWhere((test) => (test == 7), orElse: () => -1) == -1) return;
    await createList(tester, "Lista 4");
    await tapInWidget(tester, "Lista 4 0");
    for (int i = 9; i >= 0; i--) {
      await insertElement(tester, true, true, "element $i");
    }
    await insertTodoItem2(tester, 4, "Next Actions");

    await checkList([
      TextAndDeepth("element 0", 0),
      TextAndDeepth("element 1", 0),
      TextAndDeepth("element 2", 0),
      TextAndDeepth("element 3", 0),
      TextAndDeepth("element 4", 0, hasCheck: true),
      TextAndDeepth("element 5", 0),
      TextAndDeepth("element 6", 0),
      TextAndDeepth("element 7", 0),
      TextAndDeepth("element 8", 0),
      TextAndDeepth("element 9", 0),
    ], tester);
    await projectToTodolist(tester, "Next Actions");
    await checkList([TextAndDeepth("element 4", 0)], tester);
    await checkItem(tester, 0);

    await todolistToProject(tester, "Lista 4");
    await checkShowAll(tester);
    await checkList([
      TextAndDeepth("element 0", 0),
      TextAndDeepth("element 1", 0),
      TextAndDeepth("element 2", 0),
      TextAndDeepth("element 3", 0),
      TextAndDeepth("element 4", 0, hasCheck: true, isChecked: true),
      TextAndDeepth("element 5", 0),
      TextAndDeepth("element 6", 0),
      TextAndDeepth("element 7", 0),
      TextAndDeepth("element 8", 0),
      TextAndDeepth("element 9", 0),
    ], tester);
    await seeRelatedTodoItem(tester, 4);
    await projectToTodolist(tester, "Next Actions");
    await checkShowAll(tester);
    await checkItem(tester, 0);

    await todolistToProject(tester, "Lista 4");
    await checkList([
      TextAndDeepth("element 0", 0),
      TextAndDeepth("element 1", 0),
      TextAndDeepth("element 2", 0),
      TextAndDeepth("element 3", 0),
      TextAndDeepth("element 4", 0, hasCheck: true),
      TextAndDeepth("element 5", 0),
      TextAndDeepth("element 6", 0),
      TextAndDeepth("element 7", 0),
      TextAndDeepth("element 8", 0),
      TextAndDeepth("element 9", 0),
    ], tester);

    await insertTask2(
      tester: tester,

      flexibleTime: true,
      repeatType: 0,
      currentDay: DateTime.now(),
      dateTime: DateTime.now(),
      index: 3,
    );

    await checkList([
      TextAndDeepth("element 0", 0),
      TextAndDeepth("element 1", 0),
      TextAndDeepth("element 2", 0),
      TextAndDeepth("element 3", 0, hasCheck: true),
      TextAndDeepth("element 4", 0, hasCheck: true),
      TextAndDeepth("element 5", 0),
      TextAndDeepth("element 6", 0),
      TextAndDeepth("element 7", 0),
      TextAndDeepth("element 8", 0),
      TextAndDeepth("element 9", 0),
    ], tester);

    await projectToPlanner(tester);
    await checkTasks(["element 3"], tester);
    await plannerToProject(tester, "Lista 4");
    await checkList([
      TextAndDeepth("element 0", 0),
      TextAndDeepth("element 1", 0),
      TextAndDeepth("element 2", 0),
      TextAndDeepth("element 3", 0, hasCheck: true),
      TextAndDeepth("element 4", 0, hasCheck: true),
      TextAndDeepth("element 5", 0),
      TextAndDeepth("element 6", 0),
      TextAndDeepth("element 7", 0),
      TextAndDeepth("element 8", 0),
      TextAndDeepth("element 9", 0),
    ], tester);

    await projectToPlanner(tester);
    await checkItem(tester, 0);
    await plannerToProject(tester, "Lista 4");
    await checkList([
      TextAndDeepth("element 0", 0),
      TextAndDeepth("element 1", 0),
      TextAndDeepth("element 2", 0),
      TextAndDeepth("element 3", 0, hasCheck: true, isChecked: true),
      TextAndDeepth("element 4", 0, hasCheck: true),
      TextAndDeepth("element 5", 0),
      TextAndDeepth("element 6", 0),
      TextAndDeepth("element 7", 0),
      TextAndDeepth("element 8", 0),
      TextAndDeepth("element 9", 0),
    ], tester);

    await projectToTodolist(tester, "Next Actions");
    await deleteElement(tester, 0);
    await todolistToProject(tester, "Lista 4");
    await checkList([
      TextAndDeepth("element 0", 0),
      TextAndDeepth("element 1", 0),
      TextAndDeepth("element 2", 0),
      TextAndDeepth("element 3", 0, isChecked: true),

      TextAndDeepth("element 5", 0),
      TextAndDeepth("element 6", 0),
      TextAndDeepth("element 7", 0),
      TextAndDeepth("element 8", 0),
      TextAndDeepth("element 9", 0),
    ], tester);
    await insertTodoItem2(tester, 2, "Next Actions");
    await projectToPlanner(tester);
    await checkShowAll(tester);

    await uncompleteTask(tester, "Task 2");
    await checkItem(tester, 1);
    await plannerToProject(tester, "Lista 4");
    await checkList([
      TextAndDeepth("element 0", 0),
      TextAndDeepth("element 1", 0),
      TextAndDeepth("element 2", 0),
      TextAndDeepth("element 3", 0),
      TextAndDeepth("element 4", 0, hasCheck: true),
      TextAndDeepth("element 5", 0),
      TextAndDeepth("element 6", 0),
      TextAndDeepth("element 7", 0),
      TextAndDeepth("element 8", 0),
      TextAndDeepth("element 9", 0),
    ], tester);
    await projectToPlanner(tester);
    await deleteTask(tester, "Task 2");
    await plannerToProject(tester, "Lista 4");
    await checkList([
      TextAndDeepth("element 0", 0),
      TextAndDeepth("element 1", 0),
      TextAndDeepth("element 2", 0),
      TextAndDeepth("element 3", 0),
      TextAndDeepth("element 4", 0, hasCheck: true, isChecked: true),
      TextAndDeepth("element 5", 0),
      TextAndDeepth("element 6", 0),
      TextAndDeepth("element 7", 0),
      TextAndDeepth("element 8", 0),
      TextAndDeepth("element 9", 0),
    ], tester);
    await projectToPlanner(tester);
    await checkItem(tester, 0);
    await plannerToProject(tester, "Lista 4");
    await checkList([
      TextAndDeepth("element 0", 0),
      TextAndDeepth("element 1", 0),
      TextAndDeepth("element 2", 0),
      TextAndDeepth("element 3", 0),
      TextAndDeepth("element 4", 0, hasCheck: true),
      TextAndDeepth("element 5", 0),
      TextAndDeepth("element 6", 0),
      TextAndDeepth("element 7", 0),
      TextAndDeepth("element 8", 0),
      TextAndDeepth("element 9", 0),
    ], tester);
    await goBack(tester);
  });
  testWidgets('test8 Testing Planner', (WidgetTester tester) async {
    debugPrint("TEST8 STARTED");
    runApp(const MyApp());
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    if (tests.firstWhere((test) => (test == 8), orElse: () => -1) == -1) return;

    var menu = find.byIcon(Icons.menu);
    await tapInFinder(tester, menu);
    var planner = find.text("Planner");
    await tapInFinder(tester, planner);
    var past = DateTime(2023, 7, 29);
    var today = DateTime(2024, 2, 2);
    var twoMonthsLater = DateTime(2024, 4, 2);
    DateTime future = DateTime(2024, 8, 2);

    var futureOneMonthLater = DateTime(2024, 9, 2);

    await changeDate(tester, DateTime.now(), today, "chooseDate");

    await insertTask1(
      currentDay: today,
      tester: tester,
      task: "task1",
      flexibleTime: true,
      repeatType: 0,
      dateTime: today,
    );
    debugPrint("task1 finish");
    await insertTask1(
      currentDay: today,
      tester: tester,
      task: "task2",
      flexibleTime: true,
      repeatType: 0,
      dateTime: future,
    );
    debugPrint("task2 finish");
    await insertTask1(
      currentDay: today,
      tester: tester,
      task: "task2-1",
      flexibleTime: true,
      repeatType: 0,
      dateTime: past,
    );

    debugPrint("task2-1 finish");
    await insertTask1(
      currentDay: today,
      tester: tester,
      task: "task3",
      flexibleTime: false,
      repeatType: 0,
      dateTime: today,
      startTime: const TimeOfDay(hour: 0, minute: 30),
      endTime: const TimeOfDay(hour: 8, minute: 30),
    );
    debugPrint("task3 finish");

    await insertTask1(
      currentDay: today,
      tester: tester,
      task: "task4",
      flexibleTime: false,
      repeatType: 0,
      dateTime: today,
      startTime: const TimeOfDay(hour: 8, minute: 30),
      endTime: const TimeOfDay(hour: 14, minute: 30),
    );
    debugPrint("task4 finish");
    await insertTask1(
      currentDay: today,
      tester: tester,
      task: "task5",
      flexibleTime: false,
      repeatType: 1,
      dateTime: twoMonthsLater,
      startTime: const TimeOfDay(hour: 8, minute: 50),
    );

    debugPrint("task5 finish");
    await insertTask1(
      currentDay: today,
      tester: tester,
      task: "task6",
      flexibleTime: false,
      repeatType: 2,
      dateTime: today,
      startTime: const TimeOfDay(hour: 0, minute: 20),
    );
    debugPrint("task6 finish");
    await insertTask1(
      currentDay: today,
      tester: tester,
      task: "task7",
      flexibleTime: true,
      repeatType: 3,
      dateTime: today,
    );
    debugPrint("task7 finish");
    await insertTask1(
      currentDay: today,
      tester: tester,
      task: "task8",
      flexibleTime: false,
      repeatType: 4,
      dateTime: today,
      startTime: const TimeOfDay(hour: 14, minute: 30),
    );
    debugPrint("task8 finish");
    await insertTask1(
      currentDay: today,
      dateTime: today,
      tester: tester,
      task: "task9",
      flexibleTime: false,
      startTime: const TimeOfDay(hour: 0, minute: 10),
      repeatType: 5,
      customRepeatType: 0,
      value: 3,
    );
    debugPrint("task9 finish");
    await insertTask1(
      currentDay: today,
      dateTime: today,
      tester: tester,
      task: "task10",
      flexibleTime: false,
      startTime: const TimeOfDay(hour: 9, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
      repeatType: 5,
      customRepeatType: 1,
      value: "2#1010100",
    );
    debugPrint("task10 finish");
    await insertTask1(
      currentDay: today,
      tester: tester,
      task: "task11",
      flexibleTime: true,
      repeatType: 5,
      dateTime: today,
      customRepeatType: 2,
      value: 2,
    );
    debugPrint("task11 finish");
    await insertTask1(
      currentDay: today,
      tester: tester,
      task: "task12",
      flexibleTime: false,
      startTime: const TimeOfDay(hour: 7, minute: 0),
      repeatType: 5,
      dateTime: today,
      customRepeatType: 3,
      value: 2,
    );
    debugPrint("task12 finish");
    await printTasks();

    await checkTasks([
      "task1",
      "task7",
      "task11",
      "task9",
      "task6",
      "task3",
      "task12",
      "task4",
      "task10",
      "task8",
    ], tester);
    //tasks 02/02/2024 sexta 2
    //task1 - flexible única
    //task7 - flexible //monthly
    //task11  flexible a cada 2 meses
    //task9 - 0:10 a cada 3 dias
    //task6 - 0:20 //semanal
    //task3 - 0:30 única
    //task12  7:00 a cada 2 anos
    //task4 - 8:30 - 14:30 //unica 2 emeses depois
    //task10  9:00 a cada 2 semanas segunda quarta e sexta
    //task8 - 14:30 //yearly

    //task 02/08/2024 sexta 2
    //task2 flexivel única
    //task 02/04/2024
    //task5 8:30 //diaria

    await changeDate(tester, today, past, "chooseDate");
    await checkTasks(["task2-1"], tester);
    await changeDate(tester, past, future, "chooseDate");

    await checkTasks([
      "task2", //task única futura

      "task7", //task mensal
      "task11", // a cada 2 meses
      "task6", //task semanal sexta
      "task5", //diário
      "task10", //2 semanas segunda quarta e sexta
    ], tester);

    await changeDate(tester, future, futureOneMonthLater, "chooseDate");

    await checkTasks([
      "task7", ////mensal
      "task9",

      ///a cada 3 dias
      "task5", //diário
      "task10", //2 semanas segunda quarta e sexta
    ], tester);

    var sixYearsAfterToday = DateTime(today.year + 6, today.month, today.day);
    await changeDate(
      tester,
      futureOneMonthLater,
      sixYearsAfterToday,
      "chooseDate",
    );
    await checkTasks(["task7", "task11", "task12", "task5", "task8"], tester);

    await tapInText(tester, "task7");
    var textFinder = findTextFieldByText(tester, "task7");
    await typeInFinder(tester, textFinder, "task7-1");
    await tapInWidget(tester, "SaveButton1");
    debugPrint("MUDOU O NOME");
    await printTasks();

    await checkTasks(["task7-1", "task11", "task12", "task5", "task8"], tester);

    await tapInText(tester, "task7-1");
    await changeDate(tester, today, DateTime(2024, 2, 6), "datePicker");
    await tapInWidget(tester, "SaveButton1");
    debugPrint("MUDOU A DATA INICIAL");
    await printTasks();

    await checkTasks(["task11", "task12", "task5", "task8"], tester);

    await changeDate(
      tester,
      sixYearsAfterToday,
      DateTime(2024, 2, 6),
      "chooseDate",
    );

    await checkTasks(["task7-1"], tester);

    await tapInText(tester, "task7-1");
    await tapInWidget(tester, "flexible");
    await changeTime(
      tester,
      const TimeOfDay(hour: 20, minute: 00),
      "startTime",
    );
    await tapInWidget(tester, "SaveButton1");
    debugPrint("MUDOU O HORARIO INICIAL");
    await printTasks();
    await changeDate(
      tester,
      DateTime(2024, 2, 6),
      DateTime(2024, 3, 6),
      "chooseDate",
    );

    await checkTasks(["task9", "task10", "task7-1"], tester);

    await tapInText(tester, "task7-1");
    var menuItems = [
      "No repeat",
      "Every day",
      "Every week",
      "Every month",
      "Every year",
      "Custom repeat",
    ];

    await chooseItemDropdownMenu(tester, menuItems, 5, initialPosition: 3);
    menuItems = ["day", "week", "month", "year"];
    await scroll(tester, 300, false, keyName: "TaskForm");
    await chooseItemDropdownMenu(tester, menuItems, 2);
    var repeatInput = find.byKey(const Key("repeatInput"));
    await typeInFinder(tester, repeatInput, "2");
    await tapInWidget(tester, "SaveButton1");
    await checkTasks(["task9", "task10"], tester);
    await printTasks(); //checar se o task virou mensal de 2 em 2 meses
    await tapInText(tester, "task10");
    await tapInWidget(tester, "deleteButton");
    await tapInWidget(tester, "finalDelete");
    await checkTasks(["task9"], tester);
    menu = find.byIcon(Icons.menu);
    await tapInFinder(tester, menu);

    var projects = find.text("Projects");
    await tapInFinder(tester, projects);
  });
  testWidgets('test9 testing TodoList', (WidgetTester tester) async {
    debugPrint("TEST9 STARTED");
    runApp(const MyApp());
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    if (tests.firstWhere((test) => (test == 9), orElse: () => -1) == -1) return;
    var menu = find.byIcon(Icons.menu);
    await tapInFinder(tester, menu);
    var todoListButton = find.text("Todo Lists");
    await tapInFinder(tester, todoListButton);
    await createList(tester, "Lista 1");
    await tapInText(tester, "Lista 1");
    await tapInText(tester, "Lista 1");
    var input = find.byKey(const Key("nameInput"));
    await typeInFinderWithEnter(tester, input, "Lista 1-1");
    var todoListBar = find.text("Lista 1-1");
    expect(todoListBar, findsOneWidget);
    await tapInText(tester, "Lista 1-1");
    input = find.byKey(const Key("nameInput"));
    await typeInFinderWithEnter(tester, input, "Lista 1-1-1");
    await insertItem(tester, "0");
    await insertItem(tester, "1");
    await insertItem(tester, "2");
    await insertItem(tester, "3");
    await insertItem(tester, "4");
    await insertItem(tester, "5");
    await insertItem(tester, "6");
    await insertItem(tester, "7");
    await checkItems(["7", "6", "5", "4", "3", "2", "1", "0"], tester);

    await swapItems(tester, 0, 4);

    await checkItems(["6", "5", "4", "3", "7", "2", "1", "0"], tester);
    debugPrint("move1");
    await swapItems(tester, 0, 6);
    await checkItems(["5", "4", "3", "7", "2", "1", "6", "0"], tester);
    debugPrint("move2");
    await swapItems(tester, 0, 7);
    await checkItems(["4", "3", "7", "2", "1", "6", "0", "5"], tester);
    debugPrint("move3");
    await swapItems(tester, 6, 1);
    await checkItems(["4", "0", "3", "7", "2", "1", "6", "5"], tester);
    debugPrint("move3-1");
    await swapItems(tester, 6, 0);
    await checkItems(["6", "4", "0", "3", "7", "2", "1", "5"], tester);
    debugPrint("move4");
    await swapItems(tester, 7, 0); //problem
    await checkItems(["5", "6", "4", "0", "3", "7", "2", "1"], tester); //
    debugPrint("move5");
    await swapItems(tester, 3, 4);
    await checkItems(["5", "6", "4", "3", "0", "7", "2", "1"], tester);
    debugPrint("move6");
    await swapItems(tester, 5, 4);
    await checkItems(["5", "6", "4", "3", "7", "0", "2", "1"], tester);
    debugPrint("move7");
    await checkItem(tester, 3);
    await checkItem(tester, 2);
    await checkItems(["5", "6", "7", "0", "2", "1"], tester);
    debugPrint("move8");
    await swapItems(tester, 4, 2);
    await checkItems(["5", "6", "2", "7", "0", "1"], tester);
    debugPrint("move9");
    await checkShowAll(tester);
    await checkList([
      TextAndDeepth("5", 0),
      TextAndDeepth("6", 0),
      TextAndDeepth("2", 0),
      TextAndDeepth("4", 0, isChecked: true),
      TextAndDeepth("3", 0, isChecked: true),
      TextAndDeepth("7", 0),
      TextAndDeepth("0", 0),
      TextAndDeepth("1", 0),
    ], tester);

    debugPrint("move10");
    await checkShowAll(tester);
    await checkItems(["5", "6", "2", "7", "0", "1"], tester);
    debugPrint("move11");
    await swapItems(tester, 0, 2);
    await checkItems(["6", "2", "5", "7", "0", "1"], tester);
    debugPrint("move12");
    await checkShowAll(tester);
    await checkList([
      TextAndDeepth("6", 0),
      TextAndDeepth("2", 0),
      TextAndDeepth("4", 0, isChecked: true),
      TextAndDeepth("3", 0, isChecked: true),
      TextAndDeepth("5", 0),
      TextAndDeepth("7", 0),
      TextAndDeepth("0", 0),
      TextAndDeepth("1", 0),
    ], tester);
    debugPrint("move13");
    await checkShowAll(tester);
    await checkItems(["6", "2", "5", "7", "0", "1"], tester);
    debugPrint("move14");
    await insertItem(tester, "8");
    await insertItem(tester, "9");
    await checkItems(["9", "8", "6", "2", "5", "7", "0", "1"], tester);
    debugPrint("move15");
    await checkItem(tester, 1);
    await checkItem(tester, 0);
    await checkItems(["6", "2", "5", "7", "0", "1"], tester);
    debugPrint("move16");
    await swapItems(tester, 2, 0);
    await checkItems(["5", "6", "2", "7", "0", "1"], tester);
    debugPrint("move17");
    await checkShowAll(tester);
    await checkList([
      TextAndDeepth("5", 0),
      TextAndDeepth("9", 0, isChecked: true),
      TextAndDeepth("8", 0, isChecked: true),
      TextAndDeepth("6", 0),
      TextAndDeepth("2", 0),
      TextAndDeepth("4", 0, isChecked: true),
      TextAndDeepth("3", 0, isChecked: true),
      TextAndDeepth("7", 0),
      TextAndDeepth("0", 0),
      TextAndDeepth("1", 0),
    ], tester);
    debugPrint("move18");
    await deleteElement(tester, 7);
    await checkList([
      TextAndDeepth("5", 0),
      TextAndDeepth("9", 0, isChecked: true),
      TextAndDeepth("8", 0, isChecked: true),
      TextAndDeepth("6", 0),
      TextAndDeepth("2", 0),
      TextAndDeepth("4", 0, isChecked: true),
      TextAndDeepth("3", 0, isChecked: true),
      TextAndDeepth("0", 0),
      TextAndDeepth("1", 0),
    ], tester);
    debugPrint("move18");
    await goBack(tester);
    menu = find.byIcon(Icons.menu);
    await tapInFinder(tester, menu);

    var projects = find.text("Projects");
    await tapInFinder(tester, projects);
    await tester.pump(const Duration(seconds: 90));
  });

  testWidgets('test10 simple backup', (WidgetTester tester) async {
    debugPrint("TEST10 STARTED");
    runApp(const MyApp());
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    if (tests.firstWhere((test) => (test == 10), orElse: () => -1) == -1)
      return;
    await createList(tester, "Lista");
    await tapInText(tester, "Lista");
    await insertElement(tester, true, false, "SL1");
    sublistId += 1;
    await insertElement(tester, false, false, "SL2", parentId: sublistId);
    await insertElement(tester, false, true, "1", parentId: sublistId);
    await insertElement(tester, false, true, "2", parentId: sublistId);
    await insertElement(tester, false, true, "3", parentId: sublistId);
    await insertElement(tester, false, true, "4", parentId: sublistId);
    await insertElement(tester, false, true, "5", parentId: sublistId);
    await goBack(tester);

    var menu = find.byIcon(Icons.menu);
    await tapInFinder(tester, menu);
    var todoListButton = find.text("Todo Lists");
    await tapInFinder(tester, todoListButton);
    await createList(tester, "Simple List 1");
    await tapInText(tester, "Simple List 1");
    await insertItem(tester, "0");
    await insertItem(tester, "1");
    await insertItem(tester, "2");
    await insertItem(tester, "3");
    await insertItem(tester, "4");
    await insertItem(tester, "5");
    await insertItem(tester, "6");
    await insertItem(tester, "7");
    await goBack(tester);
    menu = find.byIcon(Icons.menu);
    await tapInFinder(tester, menu);
    var plannerButton = find.text("Planner");
    await tapInFinder(tester, plannerButton);
    await insertTask1(
      tester: tester,
      task: "task1",
      flexibleTime: true,
      repeatType: 0,
      currentDay: DateTime.now(),
      dateTime: DateTime.now(),
    );
    await insertTask1(
      tester: tester,
      task: "task2",
      flexibleTime: true,
      repeatType: 0,
      currentDay: DateTime.now(),
      dateTime: DateTime.now(),
    );
    await insertTask1(
      tester: tester,
      task: "task3",
      flexibleTime: true,
      repeatType: 0,
      currentDay: DateTime.now(),
      dateTime: DateTime.now(),
    );
    await tester.pump(const Duration(seconds: 10));
    var items1 = await DatabaseDao.getAllItems();
    var sublists1 = await DatabaseDao.getAllSublists();
    var lists1 = await DatabaseDao.getAllLists();
    var todoitems1 = await DatabaseDao.getAllTodoItems();
    var maxIds1 = await DatabaseDao.getBackupSettings2();
    menu = find.byIcon(Icons.menu);
    await tapInFinder(tester, menu);
    var logoutButton = find.text("Logout");
    await tapInFinder(tester, logoutButton);
    await login(tester);
    var items2 = await DatabaseDao.getAllItems();
    var sublists2 = await DatabaseDao.getAllSublists();
    var lists2 = await DatabaseDao.getAllLists();
    var todoitems2 = await DatabaseDao.getAllTodoItems();
    var maxIds2 = await DatabaseDao.getBackupSettings2();
    items1.sort((a, b) => a.id.compareTo(b.id));
    sublists1.sort((a, b) => a.id.compareTo(b.id));
    lists1.sort((a, b) => a.id.compareTo(b.id));
    todoitems1.sort((a, b) => a.id.compareTo(b.id));

    items2.sort((a, b) => a.id.compareTo(b.id));
    sublists2.sort((a, b) => a.id.compareTo(b.id));
    lists2.sort((a, b) => a.id.compareTo(b.id));
    todoitems2.sort((a, b) => a.id.compareTo(b.id));
    assert(lists1.length == lists1.length, true);
    for (int index = 0; index < lists1.length; index++) {
      var a = lists1[0];
      var b = lists2[0];
      assert(compareLists(a, b), true);
    }
    assert(sublists1.length == sublists2.length, true);
    for (int index = 0; index < sublists1.length; index++) {
      var a = sublists1[0];
      var b = sublists2[0];
      assert(compareSublists(a, b), true);
    }
    assert(items1.length == items2.length, true);
    for (int index = 0; index < items1.length; index++) {
      var a = items1[0];
      var b = items2[0];
      assert(compareItems(a, b), true);
    }
    assert(todoitems1.length == todoitems2.length, true);
    for (int index = 0; index < todoitems1.length; index++) {
      var a = todoitems1[0];
      var b = todoitems2[0];
      assert(compareTodoItems(a, b), true);
    }
    assert(compareBackupSettings(maxIds1, maxIds2));
  });

  testWidgets('test11 complex backup', (WidgetTester tester) async {
    debugPrint("TEST11 STARTED");
    runApp(const MyApp());

    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    if (tests.firstWhere((test) => (test == 11), orElse: () => -1) == -1)
      return;

    var items1 = await DatabaseDao.getAllItems();
    var sublists1 = await DatabaseDao.getAllSublists();
    var lists1 = await DatabaseDao.getAllLists();
    var todoitems1 = await DatabaseDao.getAllTodoItems();
    var backupSettigs1 = await DatabaseDao.getBackupSettings2();

    var menu = find.byIcon(Icons.menu);
    await tapInFinder(tester, menu);
    var logoutButton = find.text("Logout");
    await tapInFinder(tester, logoutButton);
    await login(tester);
    var items2 = await DatabaseDao.getAllItems();
    var sublists2 = await DatabaseDao.getAllSublists();
    var lists2 = await DatabaseDao.getAllLists();
    var todoitems2 = await DatabaseDao.getAllTodoItems();
    var backupSettigs2 = await DatabaseDao.getBackupSettings2();
    items1.sort((a, b) => a.id.compareTo(b.id));
    sublists1.sort((a, b) => a.id.compareTo(b.id));
    lists1.sort((a, b) => a.id.compareTo(b.id));
    todoitems1.sort((a, b) => a.id.compareTo(b.id));

    items2.sort((a, b) => a.id.compareTo(b.id));
    sublists2.sort((a, b) => a.id.compareTo(b.id));
    lists2.sort((a, b) => a.id.compareTo(b.id));
    todoitems2.sort((a, b) => a.id.compareTo(b.id));
    debugPrint('lista1');
    for (int index = 0; index < lists1.length; index++) {
      debugPrint('lista ${index + 1}');
      debugPrint(lists1[index].toString());
    }
    debugPrint('lista2');
    for (int index = 0; index < lists2.length; index++) {
      debugPrint('lista ${index + 1}');
      debugPrint(lists2[index].toString());
    }
    assert(lists1.length == lists2.length, true);

    for (int index = 0; index < lists1.length; index++) {
      var a = lists1[index];
      var b = lists2[index];
      try {
        assert(compareLists(a, b), true);
      } catch (e) {
        debugPrint('listas Errada');
        debugPrint('a:${a.toString()}');
        debugPrint('b:${b.toString()}');
        rethrow;
      }
    }
    assert(sublists1.length == sublists2.length, true);
    for (int index = 0; index < sublists1.length; index++) {
      var a = sublists1[index];
      var b = sublists2[index];
      try {
        assert(compareSublists(a, b), true);
      } catch (e) {
        debugPrint('sublistas Errada');
        debugPrint('a:${a.toString()}');
        debugPrint('b:${b.toString()}');
        rethrow;
      }
    }
    assert(items1.length == items2.length, true);
    for (int index = 0; index < items1.length; index++) {
      var a = items1[index];
      var b = items2[index];
      try {
        assert(compareItems(a, b), true);
      } catch (e) {
        debugPrint('items Errados');
        debugPrint('a:${a.toString()}');
        debugPrint('b:${b.toString()}');
        rethrow;
      }
    }
    assert(todoitems1.length == todoitems2.length, true);
    for (int index = 0; index < todoitems1.length; index++) {
      var a = todoitems1[index];
      var b = todoitems2[index];
      try {
        assert(compareTodoItems(a, b), true);
      } catch (e) {
        debugPrint('Todo items Errados');
        debugPrint('a:${a.toString()}');
        debugPrint('b:${b.toString()}');
        rethrow;
      }
    }
    debugPrint(backupSettigs1.toString());
    debugPrint(backupSettigs2.toString());
    assert(compareBackupSettings(backupSettigs1, backupSettigs2));
  });
  testWidgets('test12 Task check', (WidgetTester tester) async {
    debugPrint("test12 Started");
    runApp(const MyApp());
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    if (tests.firstWhere((test) => (test == 12), orElse: () => -1) == -1)
      return;
    var menu = find.byIcon(Icons.menu);
    await tapInFinder(tester, menu);
    var planner = find.text("Planner");
    await tapInFinder(tester, planner);
    var currentDay = DateTime(2024, 2, 25);
    await changeDate(
      tester,
      DateTime.now(),
      DateTime(2024, 2, 25),
      "chooseDate",
    );
    await insertTask1(
      tester: tester,
      task: "task1",
      flexibleTime: true,
      repeatType: 1,
      currentDay: currentDay,
      dateTime: currentDay,
    );
    await insertTask1(
      tester: tester,
      task: "task2",
      flexibleTime: true,
      repeatType: 1,
      currentDay: currentDay,
      dateTime: currentDay,
    );
    await insertTask1(
      tester: tester,
      task: "task3",
      flexibleTime: true,
      repeatType: 1,
      currentDay: currentDay,
      dateTime: currentDay,
    );
    await insertTask1(
      tester: tester,
      task: "task4",
      flexibleTime: true,
      repeatType: 1,
      currentDay: currentDay,
      dateTime: currentDay,
    );
    await insertTask1(
      currentDay: currentDay,
      dateTime: currentDay,
      tester: tester,
      task: "task5",
      flexibleTime: false,
      startTime: const TimeOfDay(hour: 9, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
      repeatType: 5,
      customRepeatType: 1,
      value: "2#1010100",
    );

    await checkTasks(["task1", "task2", "task3", "task4", "task5"], tester);
    await tapInWidget(tester, "cb 2");
    await tapInWidget(tester, "cb 1");
    await checkTasks(["task1", "task4", "task5"], tester);
  });

  /*testWidgets('Sign up', (WidgetTester tester) async {
    
      //teste email invalido OK
      //teste senha fraca ok
      //teste sem internet ok



  });
  testWidgets('Sign in', (WidgetTester tester) async {
    
      
      //teste sem internet ok
      //teste email invalido OK
      //teste email ou senha errados OK
      
  });*/
}
