import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/adaptative_container.dart';
import 'package:my_gtd_manager_2/components/list_app_bar.dart';
import 'package:my_gtd_manager_2/components/list_page_baseboard.dart';
import 'package:my_gtd_manager_2/components/listview.dart';
import 'package:my_gtd_manager_2/components/page_options.dart';
import 'package:my_gtd_manager_2/components/reload_page.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class ListPage extends StatefulWidget {
  final int listId;

  const ListPage(this.listId, {super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  MyListData? listData;
  List<MySublistData>? sublists;
  List<MyElementData>? items;
  late Stream<dynamic> listDataStream;
  late Stream<dynamic> sublistsStream;
  late Stream<dynamic> itemsStream;

  Future<void> setInitialItems() async {
    items = (await itemsStream.first) as List<MyElementData>;
  }

  Future<void> setInitialSublists() async {
    sublists = (await sublistsStream.first) as List<MySublistData>;
  }

  Future<void> setInitialListData() async {
    listData = (await listDataStream.first) as MyListData;
  }

  Stream<dynamic> getStream() {
    listDataStream = DatabaseDao.listStream(widget.listId);
    sublistsStream = DatabaseDao.sublistsStream(widget.listId);
    itemsStream = DatabaseDao.elementsStream(widget.listId);
    setInitialItems();
    setInitialListData();
    setInitialSublists();

    return StreamGroup.merge([itemsStream, sublistsStream, listDataStream]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ListAppBr(widget.listId, PageOptions.project),
      body: StreamBuilder<dynamic>(
        stream: getStream(),
        builder: (context, state) {
          //debugPrint("STARTING STREAMBUILDER");
          if (state.hasError) {
            return ReloadPage(id: widget.listId, option: PageOptions.project);
          } else if (!state.hasData) {
            return const Align(child: CircularProgressIndicator());
          }

          var data = state.data!;
          if (data is MyListData) {
            listData = data;
          } else if (data is List<MyElementData>) {
            items = data;
          } else if (data is List<MySublistData>) {
            sublists = data;
          }
          if (sublists != null && sublists != null && listData != null) {
            var list = DatabaseDao.elementsTile([
              ...items!,
              ...sublists!,
            ], widget.listId);

            return AdaptativeContainer(
              MyListView(rawList: list, listData: listData!),
            );
          } else {
            return const Align(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: SafeArea(child: ListPageBaseBoard(widget.listId)),

      /*floatingActionButton: CustomFloatingActionButton(
        onPressed:() async{ 
          await showDialog(
            context: context, 
            builder: (context)=>InsertElementDialog(ancestorId: widget.listId)
          );
      
        },
        tooltip: AppLocalizations.of(context)!.listPagetoolTip,
      ),*/
    );
  }
}
