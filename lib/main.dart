import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodflow/restaurant/restaurant_darshboard.dart';

import 'setup/firebase_options.dart';
import 'setup/get_it_setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupGetIt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RestaurantDashboard(),
    );
  }
}
