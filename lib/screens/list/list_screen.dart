import 'package:flutter/material.dart';
import 'package:referendum/repository/mock_repo.dart';
import 'package:referendum/screens/list/widgets/list_item.dart';

class ListScreen extends StatefulWidget {
  static final String path = "/";

  ListScreen({Key key}) : super(key: key);

  @override
  _ListScreenState createState() => new _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final items = MockRepo.getPollList();

  @override
  Widget build(BuildContext context) {
    final title = 'Let\'s start a referendum';
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListItemWidget(items[index]));
            }));
  }

  void sendVoteResult() {}
}
