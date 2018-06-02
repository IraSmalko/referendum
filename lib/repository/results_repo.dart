import 'dart:async';
import 'dart:math';

class ResultsRepo {
  static List<Future<double>> _generate() {
    List<Future<double>> results = new List();
    var random = new Random();
    for (var i = 0; i < 5; i++) {
      results.add(Future.value(random.nextDouble()));
    }

    return results;
  }

  static Stream<double> observeResults() {
    return new Stream.fromFutures(_generate()); // hz
  }
}
