import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'setup/firebase_options.dart';
import 'setup/get_it_setup.dart';
import 'utils/firestore_utils.dart';
import 'pages/food_flow_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupGetIt();

  // createServiceOrders();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FoodFlowHomePage(),
    );
  }
}
