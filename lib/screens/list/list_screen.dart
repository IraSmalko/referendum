import 'package:flutter/material.dart';
import 'package:referendum/data/poll.dart';
import 'package:referendum/repository/mock_repo.dart';

class ListScreen extends StatefulWidget {
  static final String path = "/";

  ListScreen({Key key}) : super(key: key);

  @override
  _ListScreenState createState() => new _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final items = MockRepo.getPollList();

  PollItem _selection;

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
          final item = items[index];
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: 24.0),
            child: new Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: RadioListTile(
                value: item,
                title: Text(item.id),
                groupValue: _selection,
                selected: item == _selection,
                onChanged: (s) {
                  setState(() {
                    _selection = s;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void sendVoteResult() {}
}
