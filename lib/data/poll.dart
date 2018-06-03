class Poll {
  final int id;
  final String name;

  Poll(this.id, this.name);
}

class PollItem {
  final int id;
  final String name;
  double votes;

  PollItem(this.id, this.name, this.votes);
}
