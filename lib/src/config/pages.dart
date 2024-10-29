import 'package:get/get.dart';
import 'package:inovarescan/src/bindings/auth.dart';
import 'package:inovarescan/src/bindings/company.dart';
import 'package:inovarescan/src/bindings/filter_data.dart';
import 'package:inovarescan/src/bindings/home.dart';
import 'package:inovarescan/src/bindings/internet_connection.dart';
import 'package:inovarescan/src/bindings/navigation.dart';
import 'package:inovarescan/src/bindings/order.dart';
import 'package:inovarescan/src/bindings/sql_server_connection.dart';
import 'package:inovarescan/src/bindings/user_cronos.dart';
import 'package:inovarescan/src/config/page_routes.dart';
import 'package:inovarescan/src/screens/auth/sign_in.dart';
import 'package:inovarescan/src/screens/auth/sign_up.dart';
import 'package:inovarescan/src/screens/base/base.dart';
import 'package:inovarescan/src/screens/splash/connection_error.dart';
import 'package:inovarescan/src/screens/splash/init.dart';

mixin AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PageRoutes.initRoute,
      page: () => const InitScreen(),
      bindings: [
        InternetConnectionBinding(),
        SqlServerConnectionBinding(),
        AuthBinding(),
        CompanyBinding(),
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
        SqlServerConnectionBinding(),
        AuthBinding(),
        CompanyBinding(),
        UserCronosBinding(),
      ],
    ),
    GetPage(
      name: PageRoutes.signUpRoute,
      page: () => SignUpScreen(
        userCronos: Get.parameters['userCronos'] ?? '',
      ),
      bindings: [
        SqlServerConnectionBinding(),
        CompanyBinding(),
        AuthBinding(),
      ],
    ),
    GetPage(
      name: PageRoutes.baseRoute,
      page: () => const BaseScreen(),
      bindings: [
        SqlServerConnectionBinding(),
        CompanyBinding(),
        SqlServerConnectionBinding(),
        UserCronosBinding(),
        NavigationBinding(),
        FilterDataBinding(),
        HomeBinding(),
        OrderBidding(),
      ],
    ),
  ];
}
