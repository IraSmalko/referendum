class Account {
  final int poll;
  final String priv;

  Account.fromJson(Map<String, dynamic> json)
      : poll = json['poll'],
        priv = json['priv'];
}
