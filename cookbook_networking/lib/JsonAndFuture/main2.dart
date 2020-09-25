import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'locations.dart';

Future<Locations> getGoogleOffices() async {
  const googleLocationsURL = 'https://about.google/static/data/locations.json';
  // Retrieve the locations of Google offices
  final response = await http.get(googleLocationsURL);
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(googleLocationsURL));
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _futureLocations();
  }

  Future<List<Offices>> _futureLocations() async {
    final googleOffices = await getGoogleOffices();

    List<Offices> offices = [];

    for (final o in googleOffices.offices) {
      Offices ofice = Offices(
        address: o.address,
        name: o.name,
        id: o.id,
        image: o.image,
      );
      offices.add(ofice);
    }

    return offices;
  }

  Widget projectWidget() {
    return FutureBuilder(
      future: _futureLocations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data[index].image),
              ),
              title: Text(
                snapshot.data[index].name,
              ),
              subtitle: Text(snapshot.data[index].address),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      office: snapshot.data[index],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ProjectList'),
        ),
        body: projectWidget(),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key key,
    @required this.office,
  }) : super(key: key);

  final Offices office;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("adress: \n" + office.address),
          Text("\n \noffice name: \n " + office.name)
        ],
      ),
    );
  }
}
