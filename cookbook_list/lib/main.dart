import 'package:flutter/material.dart';

import 'listitem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  get items => List<ListItem>.generate(
    1000,
    (i) => i % 6 == 0
        ? HeadingItem("Heading $i")
        : MessageItem("Sender $i", "Message body $i"),
  );

  const MyApp({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mixed List',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        items: items,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<ListItem> items;
  const MyHomePage({Key key, @required this.items}) : super(key: key);

  Widget _buildListTile(BuildContext context, int index) {
    final item = items[index];

    return ListTile(
      title: item.buildTitle(context),
      subtitle: item.buildSubtitle(context),
    );
  }

  /*
  ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
            );
          },
        ),
      ),
    );*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Floating Mixed App Bar"),
            floating: true,
            centerTitle: true,
            expandedHeight: 200,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              _buildListTile,
            ),
          )
        ],
      ),
    ));
  }
}
