import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:referendum/repository/results_repo.dart';

class ResultsScreen extends StatefulWidget {
  static final String path = "/results";

  @override
  _ResultsScreenState createState() => new _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> with TickerProviderStateMixin {
  final results = ResultsRepo.observeResults();

  final height = 96.0;
  final padding = 16.0;

  final _duration = const Duration(milliseconds: 5000);
  final _curve = Curves.fastOutSlowIn;

  List<Widget> listItems = [];
  List<AnimationController> _controllers = [];

  @override
  void initState() {
    super.initState();

    var index = 0;
    results.listen((double value) {
      listItems.add(buildListItem(context));
      _controllers[index].animateTo(value);
      index++;
    });
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
    return Scaffold(
      backgroundColor: Pigment.fromString("#263238"),
      body: new Padding(
        padding: EdgeInsets.all(padding),
        child: ListView.builder(
          itemExtent: height,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return listItems[index];
          },
        ),
      ),
    );
  }

  Widget buildListItem(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
            padding: EdgeInsets.fromLTRB(0.0, padding / 2, 0.0, padding / 2),
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
                  Center(
                    child: Text(
                      "Command 7",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
