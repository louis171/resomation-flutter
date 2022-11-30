import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_app_01/pages/details_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'data/deceased_data.dart';

import 'components/dashboard_card.dart';

// DATA
const List<Map<String, dynamic>> deceased = [
  {
    "dId": "9851a435-7aaf-440f-9118-ee0888e49646",
    "dTitle": "Miss",
    "dForenames": "Farrah",
    "dSurname": "Glennson",
    "dCommitalDate": "2022-12-02T09:00:00",
    "dCommitalLocation":
        "Local FD Branch, 123 FD Street, AnyTown, AnyCounty, AN1 TWN",
  },
  {
    "dId": "35d9bc10-24e5-4fa1-aa48-f40b966b7ccd",
    "dTitle": "Mr",
    "dForenames": "Alan",
    "dSurname": "Harrison",
    "dCommitalDate": "2022-12-05T09:30:00",
    "dCommitalLocation":
        "Local FD Branch, 123 FD Street, AnyTown, AnyCounty, AN1 TWN",
  },
  {
    "dId": "59257205-e972-4897-a4c8-1a810e8fc8e5",
    "dTitle": "Mrs",
    "dForenames": "Julie",
    "dSurname": "Kenn",
    "dCommitalDate": "2022-12-07T10:00:00",
    "dCommitalLocation":
        "Local FD Branch, 123 FD Street, AnyTown, AnyCounty, AN1 TWN",
  },
  {
    "dId": "477a573a-2e54-47a7-b457-ac4225706c48",
    "dTitle": "Mr",
    "dForenames": "Jack",
    "dSurname": "Guest",
    "dCommitalDate": "2022-12-03T09:00:00",
    "dCommitalLocation":
        "Local FD Branch, 123 FD Street, AnyTown, AnyCounty, AN1 TWN",
  }
];

final deceasedList = deceased.map((e) => DeceasedData.fromJson(e));

Future<DeceasedData> fetchDeceasedData() async {
  final response = await http.get(
      Uri.parse(
          'http://localhost:5208/api/deceased/read?dId=9851a435-7aaf-440f-9118-ee0888e49646'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiY2IwMTQyOWYtZTk3YS00ZjJjLThlN2UtZTkwNmIyMDg2NTkyIiwibmJmIjoxNjY5ODI0NTkxLCJleHAiOjE2Njk4MjgxOTEsImlhdCI6MTY2OTgyNDU5MSwiaXNzIjoiT2FrVGVjaG5vbG9neSIsImF1ZCI6IlJlc29tYXRpb24ifQ.FSr--WKXF0UU3TiX0hpXEZD_ZBMp76rQISP17QUCWkI',
      });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    log(jsonDecode(response.toString()));
    return DeceasedData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

// SCREENS
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<DeceasedData> deceasedData;

  @override
  void initState() {
    super.initState();
    deceasedData = fetchDeceasedData();
    log("wow");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.count(
              childAspectRatio: 2.8,
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 1,
              children: deceasedList
                  .map(
                    (DeceasedData deceased) => DeceasedCard(deceased: deceased),
                  )
                  .toList()),
        ));
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => {},
              child: const Text('Button'),
            ),
          ],
        ),
      ),
    );
  }
}

// LOCATIONS
class DashboardLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/dashboard/:dId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final pages = [
      const BeamPage(
        key: ValueKey('dashboard'),
        title: 'dashboard',
        type: BeamPageType.slideLeftTransition,
        child: DashboardScreen(),
      ),
    ];
    final String? dIdParameter = state.pathParameters['dId'];
    if (dIdParameter != null) {
      pages.add(
        BeamPage(
          key: ValueKey('book-$dIdParameter'),
          title: 'Book #$dIdParameter',
          type: BeamPageType.fadeTransition,
          child: DetailsScreen(dId: dIdParameter),
        ),
      );
    }
    return pages;
  }
}

class SettingsLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/settings'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('settings'),
          title: 'Settings',
          type: BeamPageType.slideRightTransition,
          child: SettingsScreen(),
        ),
      ];
}

// APP
class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key, required this.beamerKey});

  final GlobalKey<BeamerState> beamerKey;

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  late BeamerDelegate _beamerDelegate;
  int _currentIndex = 0;

  void _setStateListener() => setState(() {});

  @override
  void initState() {
    super.initState();
    _beamerDelegate = widget.beamerKey.currentState!.routerDelegate;
    _beamerDelegate.addListener(_setStateListener);
  }

  @override
  Widget build(BuildContext context) {
    _currentIndex =
        _beamerDelegate.currentBeamLocation is DashboardLocation ? 0 : 1;
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: const [
        BottomNavigationBarItem(label: 'Dashboard', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings)),
      ],
      onTap: (index) => _beamerDelegate.beamToNamed(
        index == 0 ? '/dashboard' : '/settings',
      ),
    );
  }

  @override
  void dispose() {
    _beamerDelegate.removeListener(_setStateListener);
    super.dispose();
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _beamerKey = GlobalKey<BeamerState>();
  final _routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        DashboardLocation(),
        SettingsLocation(),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Beamer(
        key: _beamerKey,
        routerDelegate: _routerDelegate,
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        beamerKey: _beamerKey,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    initialPath: '/dashboard',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) => HomeScreen(),
      },
    ),
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    );
  }
}

void main() => runApp(MyApp());
