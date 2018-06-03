import 'package:referendum/data/poll.dart';

class MockRepo {
  static List<PollItem> getPollList() {
    return List<PollItem>.generate(5, (i) => PollItem("Helper class which implements " + i.toString()));
  }
}
