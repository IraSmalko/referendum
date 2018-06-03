import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
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

  final height = 96.0;
  final padding = 16.0;
  PollItem _selection;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return new Scaffold(
      backgroundColor: Pigment.fromString("#263238"),
      key: _scaffoldKey,
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return new Padding(
              padding: EdgeInsets.fromLTRB(0.0, padding / 2, 0.0, padding / 2),
              child: Material(
                color: (item == _selection) ? Colors.white.withAlpha(40) : Colors.white10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: height,
                      width: width,
                      child: new Center(
                        child: RadioListTile(
                          activeColor: Colors.white,
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
                    ),
                  ],
                ),
              ),
            );
          },
        ),
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
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Pigment.fromString("#ff6a00"), Pigment.fromString("#ee0979")])),
                        child: new SizedBox(
                          height: width * 0.4,
                          width: width * 0.4,
                          child: InkWell(onTap: sendVoteResult),
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: new Offset(width * 0.08, width * 0.1),
                    child: Text(
                      'Vote',
                      style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
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
