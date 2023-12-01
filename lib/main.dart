import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

@pragma('vm:entry-point')
void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final int helloAlarmID = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Alarm Manager Demo'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              AndroidAlarmManager.periodic(
                const Duration(minutes: 1),
                helloAlarmID,
                printHello,
                exact: true,
                wakeup: true,
              );
            },
            child: const Text("Activé l'alarme"),
          ),
        ),
      ),
    );
  }
}
