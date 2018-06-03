import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:referendum/data/poll.dart';
import 'package:referendum/repository/results_repo.dart';
import 'package:referendum/screens/results/results.dart';

class ListScreen extends StatefulWidget {
  static final String path = "/list";

  ListScreen({Key key}) : super(key: key);

  @override
  _ListScreenState createState() => new _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _items = <PollItem>[];

  final height = 96.0;
  final padding = 16.0;
  PollItem _selection;

  @override
  void initState() {
    super.initState();

    final items = Repo.repo.getPollList();
    setState(() {
      _items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return new Scaffold(
      backgroundColor: Pigment.fromString("#263238"),
      key: _scaffoldKey,
      body: new Padding(
        padding: EdgeInsets.fromLTRB(0.0, padding, 0.0, 0.0),
        child: new ListView.builder(
          itemCount: _items.length + 1,
          itemExtent: height,
          itemBuilder: (context, index) {
            if (index == 0) {
              return new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    "Vote for the team",
                    textScaleFactor: 2.0,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            }
            return _buildListItem(_items[index - 1]);
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
                          child: InkWell(
                            onTap: _sendVoteResult,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: new Offset(width * 0.05, width * 0.1),
                    child: new InkWell(
                      onTap: _sendVoteResult,
                      child: FlatButton(
                        onPressed: null,
                        child: Text(
                          'Vote',
                          style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
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

  Widget _buildListItem(PollItem item) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(padding, padding / 2, padding, padding / 2),
      child: Material(
        color: Pigment.fromString("#263238"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: new Container(
          decoration: (item == _selection)
              ? BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Pigment.fromString("#ff6a00"), Pigment.fromString("#ee0979")]))
              : BoxDecoration(color: Colors.white10),
          child: RadioListTile(
            activeColor: Colors.white,
            value: item,
            title: new Container(
              alignment: Alignment.centerLeft,
              child: Text(
                item.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
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
    );
  }

  void _sendVoteResult() {
    if (_selection == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please select a command!')));
    } else {
      // TODO: send selected team
      Navigator.of(context).pushReplacementNamed(ResultsScreen.path);
    }
  }
}
