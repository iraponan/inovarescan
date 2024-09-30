import 'package:flutter/services.dart';

mixin AppSetup {
  static void setupApp() async {
    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
  }
}
