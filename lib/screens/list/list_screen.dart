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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final items = MockRepo.getPollList();

  PollItem _selection;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final title = 'Let\'s start a referendum';
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      key: _scaffoldKey,
      body: new ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: 24.0),
            child: new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
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
      floatingActionButton: new Transform.translate(
        offset: new Offset(width * 0.2 + 24.0, width * 0.2 + 24.0),
        child: Container(
          decoration: BoxDecoration(gradient: RadialGradient(radius: 0.5, colors: [Colors.black, Colors.transparent])),
          child: new Transform.translate(
            offset: new Offset(0.0, 0.0),
            child: new Padding(
              padding: const EdgeInsets.all(30.0),
              child: new Stack(
                children: <Widget>[
                  new Ink(
                    child: new Material(
                      shape: new CircleBorder(),
                      color: Colors.green,
                      child: new SizedBox(
                        height: width * 0.35,
                        width: width * 0.35,
                        child: InkWell(onTap: sendVoteResult),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: new Offset(width * 0.08, width * 0.1),
                    child: Text(
                      'Vote',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendVoteResult() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Hi sendVoteResult')));
  }
}
