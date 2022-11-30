import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

/// The details screen
class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen]

  const DetailsScreen({Key? key, required this.dId}) : super(key: key);

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
