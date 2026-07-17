import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/adaptative_container.dart';
import 'package:my_gtd_manager_2/components/floating_action_button.dart';
import 'package:my_gtd_manager_2/components/listsview.dart';
import 'package:my_gtd_manager_2/components/name_delete_dialog.dart';
import 'package:my_gtd_manager_2/components/page_options.dart';
import 'package:my_gtd_manager_2/components/reload_page.dart';
import 'package:my_gtd_manager_2/components/sanduich_menu_helpers.dart';

import 'package:my_gtd_manager_2/database/database.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

class ListsPage extends StatefulWidget {
  final PageOptions option;
  final Stream<List<MyListData>> stream;
  final List<MyListData> Function(List<MyListData>) orderList;
  const ListsPage({
    required this.orderList,
    required this.stream,
    required this.option,
    super.key,
  });

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  @override
  Widget build(BuildContext pageContext) {
    var menu = (widget.option == PageOptions.projects) ? 1 : 0;
    var title = (widget.option == PageOptions.projects)
        ? AppLocalizations.of(context)!.projects
        : AppLocalizations.of(context)!.todolists;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),

        title: Text(title),
      ),

      body: StreamBuilder<List<MyListData>>(
        stream: widget.stream,

        builder: (context, state) {
          if (state.hasError) {
            return ReloadPage(option: widget.option);
          }
          if (!state.hasData) {
            return const Align(child: CircularProgressIndicator());
          }
          var list = widget.orderList(state.data!);
          return AdaptativeContainer(ListsView(list));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFloatingActionButton(
        //key: Key('addListButton'),
        tooltip: AppLocalizations.of(context)!.listsPageTooltip,
        onPressed: () {
          createList(context);
        },
      ),
      drawer: MyDrawer(menu),
    );
  }

  Future<void> getNewName(String newName) async {
    await DatabaseDao.addList(
      newName,
      widget.option == PageOptions.todoListsPage,
    );
  }

  createList(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => NameDeleteDialog(
        isProject: widget.option == PageOptions.projects,
        isNew: true,
        setName: getNewName,
      ),
    );
  }
}
