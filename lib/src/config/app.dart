import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/page_routes.dart';
import 'package:inovarescan/src/config/pages.dart';
import 'package:inovarescan/src/config/theme.dart';

class AppInovareScan extends StatelessWidget {
  const AppInovareScan({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'InovareScan',
      debugShowCheckedModeBanner: false,
      theme: ThemeProject.theme,
      initialRoute: PageRoutes.initRoute,
      getPages: AppPages.pages,
      enableLog: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pt', 'BR'),
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
    );
  }
}
