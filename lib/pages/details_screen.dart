import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

import 'package:http/http.dart' as http;

/// The details screen
class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen]

  const DetailsScreen({Key? key, required this.dId}) : super(key: key);

  //method for data
  void readData() async {
    var url = Uri.https('example.com', 'whatsit/create');
    var response =
        await http.post(url, body: {'name': 'doodle', 'color': 'blue'});

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  final String dId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.beamToNamed("/dashboard");
              },
              child: const Text('dashboard'),
            ),
            Text(dId)
          ],
        ),
      ),
    );
  }
}
