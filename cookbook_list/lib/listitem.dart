import 'package:flutter/material.dart';

/// The base class for the different types of items the list can contain.

abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
  @override
  Widget buildTitle(BuildContext context) {
    return Text(heading, style: Theme.of(context).textTheme.headline5);
  }

  @override
  Widget buildSubtitle(BuildContext context) => Text("null");
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(@required this.sender, @required this.body);

  Widget buildTitle(BuildContext context) => Text(sender);

  Widget buildSubtitle(BuildContext context) => Text(body);
}
