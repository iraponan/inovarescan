import 'dart:convert';

import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/connection.dart';
import 'package:inovarescan/src/helpers/mssql/querys.dart';
import 'package:inovarescan/src/results/mssql_execute_query.dart';
import 'package:inovarescan/src/services/sql_server_connection.dart';

class UsersCronosRepository {
  SqlServerConnection sqlConnection = Get.find<SqlServerConnection>();
  final companyController = Get.find<ConnectionController>();

  Future<MssqlExecuteQueryResult<bool>> validateUserFromCronos({required String user, required String password}) async {
    String query = QuerysCronos.selectUser(user: user, password: password);
    await sqlConnection.tryConnected(companyController.connection);
    if (sqlConnection.isConnected) {
      List<dynamic> result = jsonDecode(await sqlConnection.mssqlConnection.getData(query));
      return MssqlExecuteQueryResult.success(result.isNotEmpty);
    } else {
      return MssqlExecuteQueryResult.error('Não foi possível conectar ao servidor do Cronos por favor tente novamente.');
    }
  }

  Future<MssqlExecuteQueryResult<List<dynamic>>> getUserAccessCompaniesFromCronos({required String user}) async {
    String query = QuerysCronos.selectUserAccessCompanies(user: user);
    await sqlConnection.tryConnected(companyController.connection);
    if (sqlConnection.isConnected) {
      List<dynamic> result = jsonDecode(await sqlConnection.mssqlConnection.getData(query));
      return MssqlExecuteQueryResult.success(result);
    } else {
      return MssqlExecuteQueryResult.error('Não foi possível conectar ao servidor do Cronos por favor tente novamente.');
    }
  }

  Future<void> disconnectMssql() async {
    await sqlConnection.mssqlConnection.disconnect();
  }
}
