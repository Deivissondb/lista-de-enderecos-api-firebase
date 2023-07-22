import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_test_api/src/services/routes.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: "/listAddressPage",
      routes: RoutesApp.routesList,
      onGenerateRoute: RoutesApp.onGenerateRoute,
    );
  }
}
