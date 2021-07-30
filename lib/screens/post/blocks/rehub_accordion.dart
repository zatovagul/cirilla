import 'package:cirilla/mixins/mixins.dart';
import 'package:flutter/material.dart';

class Accordion extends StatelessWidget with Utility {
  final Map<String, dynamic> block;

  const Accordion({Key key, this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map attrs = get(block, ['attrs'], {}) is Map ? get(block, ['attrs'], {}) : {};

    List tabs = get(attrs, ['tabs'], []);
    if (tabs.isEmpty) {
      return Container();
    }
    return ListTab(tabs: tabs);
  }
}

class ListTab extends StatefulWidget {
  final List tabs;
  const ListTab({Key key, @required this.tabs}) : super(key: key);

  @override
  _ListTabState createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> with Utility {
  List<int> openVisit = [];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List tabs = widget?.tabs ?? [];

    if (tabs.isEmpty) {
      return Container();
    }
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        List<int> data = openVisit;
        if (!isExpanded) {
          openVisit.add(index);
        } else {
          openVisit.remove(index);
        }
        setState(() {
          openVisit = data;
        });
      },
      children: tabs.map<ExpansionPanel>((dynamic item) {
        int index = tabs.indexOf(item);
        String title = item is Map ? get(item, ['title'], '') : '';
        String content = item is Map ? get(item, ['content'], '') : '';
        bool isExpanded = openVisit.indexWhere((int element) => element == index) > -1;
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(title, style: theme.textTheme.subtitle1),
            );
          },
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: theme.dividerColor))),
            child: Text(content),
          ),
          isExpanded: isExpanded,
        );
      }).toList(),
    );
  }
}
