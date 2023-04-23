import 'package:app_bin_mobile/src/core/routes/app_route.dart';
import 'package:app_bin_mobile/src/features/apps/widgets/app_installed_list.dart';
import 'package:app_bin_mobile/src/features/stats/apps_statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: generateRoute,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Application> myApps = [];

  void getListOfApps() async {
    final tempList =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);
    setState(() {
      myApps = tempList
          .where((element) =>
              element.category == ApplicationCategory.game ||
              element.category == ApplicationCategory.social)
          .toList();
    });
  }

  @override
  void initState() {
    getListOfApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
          child: myApps.isNotEmpty
              ? AppInstalledList(
                  apps: myApps,
                )
              : const Center(child: CircularProgressIndicator())),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppsStatisticsScreen.routeName,
            arguments: AppsStatisticsScreenArgs(myApps: myApps),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
