import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:task1_1/DoctorService.dart';
import 'package:task1_1/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'DoctorCategory.dart';
import 'firebase_options.dart';

import 'package:hive_flutter/hive_flutter.dart';

// ...

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  // final appDocumentDirectory = await getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirectory.path);
  await Hive.openBox<DoctorCategory>('categories');

  runApp(
    ChangeNotifierProvider(
      create: (context) => DoctorService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: HomePage(),
    ));
  }
}
