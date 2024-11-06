import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/connection.dart';
import 'package:inovarescan/src/helpers/mssql/querys.dart';
import 'package:inovarescan/src/results/mssql_execute_query.dart';
import 'package:inovarescan/src/services/sql_server_connection.dart';

class OrderItemsRepository {
  SqlServerConnection sqlConnection = Get.find<SqlServerConnection>();
  final connectionController = Get.find<ConnectionController>();

  Future<MssqlExecuteQueryResult<List<dynamic>>> getOrdersItems({required int idMov}) async {
    String query = QuerysCronos.selectOrderItems(idMov: idMov.toString());
    await sqlConnection.tryConnected(connectionController.connection);
    if (sqlConnection.isConnected) {
      List<dynamic> result = jsonDecode(await sqlConnection.mssqlConnection.getData(query));
      return MssqlExecuteQueryResult.success(result);
    } else {
      return MssqlExecuteQueryResult.error('Não foi possível conectar ao servidor do Cronos por favor tente novamente.');
    }
  }

  Future<MssqlExecuteQueryResult<dynamic>> createFunctionToBase64() async {
    String query = QuerysCronos.selectCreateFunctionToBase64();
    await sqlConnection.tryConnected(connectionController.connection);
    if (sqlConnection.isConnected) {
      log(query);
      final result = jsonDecode(await sqlConnection.mssqlConnection.writeData(query));
      return MssqlExecuteQueryResult.success(result);
    } else {
      return MssqlExecuteQueryResult.error('Não foi possível conectar ao servidor do Cronos por favor tente novamente.');
    }
  }

  Future<void> disconnectMssql() async {
    await sqlConnection.mssqlConnection.disconnect();
  }
}
