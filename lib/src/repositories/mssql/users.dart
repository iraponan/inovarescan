import 'dart:convert';

import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/mssql/querys.dart';
import 'package:inovarescan/src/services/sql_server_connection.dart';

class UsersCronosRepository {
  SqlServerConnection sqlConnection = Get.find<SqlServerConnection>();

  Future<bool> validateUser(String user, String password) async {
    String query = QuerysCronos.selectUser(user, password);
    List<dynamic> result = jsonDecode(await sqlConnection.mssqlConnection.getData(query));
    return result.isNotEmpty;
  }
}
