import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencies = await initDependencies();
  runApp(App(dependencies: dependencies));
}