import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:referendum/data/poll.dart';
import 'package:referendum/repository/results_repo.dart';
import 'package:referendum/screens/home/home.dart';

class ResultsScreen extends StatefulWidget {
  static final String path = "/results";

  @override
  _ResultsScreenState createState() => new _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> with TickerProviderStateMixin {
  final height = 96.0;
  final padding = 16.0;

  final _duration = const Duration(milliseconds: 2000);
  final _curve = Curves.fastOutSlowIn;

  List<Widget> listItems = [];
  List<AnimationController> _controllers = [];

  @override
  void initState() {
    super.initState();

//    var firstRun = true;
//    Repo.repo.getResults().listen((List<double> resultList) {
//      if (firstRun) {
//        firstRun = false;
//        for (var i = 0; i < resultList.length; i++) {
//          listItems.insert(i, _buildListItem(context));
//          _controllers[i].animateTo(resultList[i]);
//        }
//      } else {
//        new Future.delayed(const Duration(seconds: 2), () {
//          for (var i = 0; i < resultList.length; i++) {
//            _controllers[i].animateTo(resultList[i]);
//          }
//        });
//      }
//    });
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final items = Repo.repo.getPollList();
    for (var i = 0; i < items.length; i++) {
      listItems.insert(i, _buildListItem(items[i], width));
    }

    return Scaffold(
      backgroundColor: Pigment.fromString("#263238"),
      body: new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
        child: ListView.builder(
          itemExtent: height,
          itemCount: listItems.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return _buildHeader();
            } else {
              return listItems[index - 1];
            }
          },
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.pinkAccent,
          child: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.path);
          }),
    );
  }

  Widget _buildHeader() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
          "Results",
          textScaleFactor: 2.0,
          style: TextStyle(color: Colors.white),
        ),
        new Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
          child: Text(
            "People voted: 5/7",
            textScaleFactor: 1.0,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(PollItem item, double width) {
    final controller = new AnimationController(
      duration: _duration,
      vsync: this,
    );

    final animation = new CurvedAnimation(parent: controller, curve: _curve)
      ..addListener(() {
        setState(() {});
      });
    _controllers.add(controller);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => new Padding(
            padding: EdgeInsets.fromLTRB(padding, padding / 2, padding, padding / 2),
            child: Material(
              color: Colors.white10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    height: height,
                    width: (width - padding * 2) * controller.value,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Pigment.fromString("#ff6a00"), Pigment.fromString("#ee0979")])),
                  ),
                  new Center(
                    child: new Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Row(
                        children: [
                          new Expanded(
                            child: new Text(
                              item.name,
                              style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                          new Text(
//                            "${item.votes / 18 * 100}%"
                                "41%", // TODO: calculate result
                            style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
