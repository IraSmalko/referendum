import 'package:flutter/material.dart';
import 'package:referendum/data/poll.dart';

class ListItemWidget extends StatelessWidget {
  final PollItem item;

  ListItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: 48.0),
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ListTile(
            title: Text(item.id),
          ),
        ));
  }
}
