import 'package:referendum/data/poll.dart';

class MockRepo {
  static List<PollItem> getPollList() {
    return List<PollItem>.generate(
        100, (i) => PollItem("Helper class which implements"));
  }
}
