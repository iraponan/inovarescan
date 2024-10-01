import 'package:get/get.dart';
import 'package:inovarescan/src/bindings/auth.dart';
import 'package:inovarescan/src/bindings/company.dart';
import 'package:inovarescan/src/bindings/internet_connection.dart';
import 'package:inovarescan/src/bindings/sql_server_connection.dart';
import 'package:inovarescan/src/bindings/user_cronos.dart';
import 'package:inovarescan/src/config/page_routes.dart';
import 'package:inovarescan/src/screens/auth/sign_in.dart';
import 'package:inovarescan/src/screens/auth/sign_up.dart';
import 'package:inovarescan/src/screens/base.dart';
import 'package:inovarescan/src/screens/splash/connection_error.dart';
import 'package:inovarescan/src/screens/splash/init.dart';

mixin AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PageRoutes.initRoute,
      page: () => const InitScreen(),
      bindings: [
        InternetConnectionBinding(),
        AuthBinding(),
      ],
    ),
    GetPage(
      name: PageRoutes.connectionErrorRoute,
      page: () => const ConnectionErrorScreen(),
    ),
    GetPage(
      name: PageRoutes.signInRoute,
      page: () => const SignInScreen(),
      bindings: [
        AuthBinding(),
        CompanyBinding(),
        SqlServerConnectionBinding(),
        UserCronosBinding(),
      ],
    ),
    GetPage(
      name: PageRoutes.signUpRoute,
      page: () => SignUpScreen(
        userCronos: Get.parameters['userCronos'] ?? '',
      ),
      bindings: [
        CompanyBinding(),
        AuthBinding(),
        SqlServerConnectionBinding(),
      ],
    ),
    GetPage(
      name: PageRoutes.baseRoute,
      page: () => const BaseScreen(),
    ),
  ];
}
