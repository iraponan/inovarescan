import 'package:flutter/material.dart';
import 'package:inovarescan/src/config/app.dart';
import 'package:inovarescan/src/config/initialize.dart';
import 'package:inovarescan/src/config/setup.dart';

Future<void> main() async {
  await AppInitialize.initializeApp();
  await AppInitialize.initializeEnv();
  await AppInitialize.initializeParseServer();

  AppSetup.setupApp();

  runApp(const AppInovareScan());
}
