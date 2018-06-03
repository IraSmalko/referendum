import 'dart:async';
import 'dart:math';

class ResultsRepo {
  Stream<List<double>> getResults() async* {
    final random = new Random();
    final results = <double>[];

    for (var i = 0; i < 5; i++) {
      results.add(random.nextDouble());
    }

    yield results;
  }
}
