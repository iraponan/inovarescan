import 'dart:convert';

import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/connection.dart';
import 'package:inovarescan/src/helpers/mssql/querys.dart';
import 'package:inovarescan/src/results/mssql_execute_query.dart';
import 'package:inovarescan/src/services/sql_server_connection.dart';

class HomeDataCronosRepository {
  SqlServerConnection sqlConnection = Get.find<SqlServerConnection>();
  final connectionController = Get.find<ConnectionController>();

  Future<MssqlExecuteQueryResult<Map<String, dynamic>>> getPercQttSeparationsFromCronos(
      {required String typeData, DateTime? dateIni, DateTime? dateEnd, required Map<String, bool> companies}) async {
    String query = QuerysCronos.selectPercQttSeparations(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd, companies: companies);
    await sqlConnection.tryConnected(connectionController.connection);
    if (sqlConnection.isConnected) {
      List<dynamic> result = jsonDecode(await sqlConnection.mssqlConnection.getData(query));
      return MssqlExecuteQueryResult.success(result.first);
    } else {
      return MssqlExecuteQueryResult.error('Não foi possível conectar ao servidor do Cronos por favor tente novamente.');
    }
  }

  Future<MssqlExecuteQueryResult<List<dynamic>>> getQttBySeparatorFromCronos(
      {required String typeData, DateTime? dateIni, DateTime? dateEnd, required Map<String, bool> companies}) async {
    String query = QuerysCronos.selectQttBySeparator(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd, companies: companies);
    await sqlConnection.tryConnected(connectionController.connection);
    if (sqlConnection.isConnected) {
      List<dynamic> result = jsonDecode(await sqlConnection.mssqlConnection.getData(query));
      return MssqlExecuteQueryResult.success(result);
    } else {
      return MssqlExecuteQueryResult.error('Não foi possível conectar ao servidor do Cronos por favor tente novamente.');
    }
  }

  Future<MssqlExecuteQueryResult<List<dynamic>>> getQttPerHourFromCronos(
      {required String typeData, DateTime? dateIni, DateTime? dateEnd, required Map<String, bool> companies}) async {
    String query = QuerysCronos.selectQttPerHour(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd, companies: companies);
    await sqlConnection.tryConnected(connectionController.connection);
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
