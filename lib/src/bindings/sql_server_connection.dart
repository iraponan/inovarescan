import 'package:get/get.dart';
import 'package:inovarescan/src/services/sql_server_connection.dart';

class SqlServerConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SqlServerConnection());
  }
}
