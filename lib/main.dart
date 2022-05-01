import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whats_app/app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}


