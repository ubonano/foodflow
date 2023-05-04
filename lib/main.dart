import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'setup/firebase_options.dart';
import 'setup/get_it_setup.dart';
import 'setup/logger_setup.dart';
import 'setup/router.dart';
import 'ui/screens/table_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupLogger();
  setupGetIt();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Food Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routerConfig: _appRouter.config(),
      // home: const TableListScreen(),
    );
  }
}
