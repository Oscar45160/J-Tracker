import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cannabis_tracker/providers/consumption_provider.dart';
import 'package:cannabis_tracker/services/database_service.dart';
import 'package:cannabis_tracker/screens/home_screen.dart';
import 'package:cannabis_tracker/screens/last_entries_screen.dart';
import 'package:cannabis_tracker/screens/add_consumption_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConsumptionProvider>(
          create: (context) => ConsumptionProvider(DatabaseService()),
        ),
      ],
      child: MaterialApp(
        title: 'Cannabis Tracker',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/lastEntries': (context) => LastEntriesScreen(),
          '/addConsumption': (context) => AddConsumptionScreen(),
        },
      ),
    );
  }
}
