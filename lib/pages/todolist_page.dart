import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/adaptative_container.dart';
import 'package:my_gtd_manager_2/components/change_todoitem_dialog.dart';
import 'package:my_gtd_manager_2/components/floating_action_button.dart';
import 'package:my_gtd_manager_2/components/list_app_bar.dart';
import 'package:my_gtd_manager_2/components/list_page_baseboard.dart';
import 'package:my_gtd_manager_2/components/page_options.dart';
import 'package:my_gtd_manager_2/components/reload_page.dart';
import 'package:my_gtd_manager_2/components/todo_list_view.dart';
import 'package:my_gtd_manager_2/database/database.dart';
import 'package:my_gtd_manager_2/math.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

class TodoListPage extends StatefulWidget {
  final int listId;

  const TodoListPage(this.listId, {super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  MyListData? listData;
  List<TodoElementData>? items;
  late Stream<dynamic> listDataStream;

  late Stream<dynamic> itemsStream;

  Future<void> setInitialItems() async {
    items = (await itemsStream.first) as List<TodoElementData>;
  }

  Future<void> setInitialListData() async {
    listData = (await listDataStream.first) as MyListData;
  }

  Stream<dynamic> getStream() {
    listDataStream = DatabaseDao.listStream(widget.listId);
    itemsStream = DatabaseDao.todoelementsStream(widget.listId);
    setInitialItems();
    setInitialListData();

    return StreamGroup.merge([itemsStream, listDataStream]);
  }

  Future<void> unselectAll() async {
    if (items == null) return;

    for (var item in items!) {
      await DatabaseDao.changetodoItemIsChecked(
        false,
        item.id,
        projectId: item.relatedElementId,
      );
    }
  }

  void printShowAllList(List<TodoElementData> items) {
    debugPrint("SHOWALL LIST");
    var cont = -1;
    for (var item in items) {
      cont++;
      debugPrint("$cont: ${item.name}");
    }
    debugPrint("FIM SHOWALL LIST");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ListAppBr(widget.listId, PageOptions.todoListPage),
      body: StreamBuilder<dynamic>(
        stream: getStream(),
        builder: (context, state) {
          //debugPrint("STARTING STREAMBUILDER");
          if (state.hasError) {
            return ReloadPage(
              id: widget.listId,
              option: PageOptions.todoListPage,
            );
          } else if (!state.hasData) {
            return const Align(child: CircularProgressIndicator());
          }

          var data = state.data!;
          if (data is MyListData) {
            listData = data;
            debugPrint("GOT LISTDATA");
          } else {
            debugPrint("GOT ITEMS");
            items = data;
          }
          if (items != null && listData != null) {
            items!.sort((a, b) => myCompareTo(b.position, a.position));
            printShowAllList(items!);
            return AdaptativeContainer(
              TodoListView(realList: items!, showAll: listData!.showAll),
            );
          } else {
            return const Align(child: CircularProgressIndicator());
          }
        },
      ),
      //TODO projectId passando valores errados
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => TodoItemDialog(listId: widget.listId),
          );
        },
        tooltip: AppLocalizations.of(context)!.todoPagetoolTip,
      ),
      bottomNavigationBar: SafeArea(
        child: ListPageBaseBoard(widget.listId, buttonfunction: unselectAll),
      ),
    );
  }
}
