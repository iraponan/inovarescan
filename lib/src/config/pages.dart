import 'package:get/get.dart';
import 'package:inovarescan/src/bindings/auth.dart';
import 'package:inovarescan/src/bindings/connection.dart';
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
        ConnectionBinding(),
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
    ),
    GetPage(
      name: PageRoutes.signUpRoute,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: PageRoutes.baseRoute,
      page: () => const BaseScreen(),
    ),
  ];
}
