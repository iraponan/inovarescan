import 'dart:convert';

import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/connection.dart';
import 'package:inovarescan/src/helpers/mssql/querys.dart';
import 'package:inovarescan/src/models/order.dart';
import 'package:inovarescan/src/results/mssql_execute_query.dart';
import 'package:inovarescan/src/services/sql_server_connection.dart';

class OrderRepository {
  SqlServerConnection sqlConnection = Get.find<SqlServerConnection>();
  final connectionController = Get.find<ConnectionController>();

  Future<MssqlExecuteQueryResult<List<dynamic>>> getOrders({
    required String typeData,
    DateTime? dateIni,
    DateTime? dateEnd,
    required int page,
    required int itemsPerPage,
    required Map<String, bool> companies,
    required Map<List<String>, bool> statusMov,
  }) async {
    String query = QuerysCronos.selectOrders(
      typeData: typeData,
      dateIni: dateIni,
      dateEnd: dateEnd,
      page: page,
      itemsPerPage: itemsPerPage,
      companies: companies,
      statusMov: statusMov,
    );
    await sqlConnection.tryConnected(connectionController.connection);
    if (sqlConnection.isConnected) {
      List<dynamic> result = jsonDecode(await sqlConnection.mssqlConnection.getData(query));
      return MssqlExecuteQueryResult.success(result);
    } else {
      return MssqlExecuteQueryResult.error('Não foi possível conectar ao servidor do Cronos por favor tente novamente.');
    }
  }

  Future<MssqlExecuteQueryResult<Map<String, dynamic>>> updateStatusSepOrder({required Order order}) async {
    String query = QuerysCronos.updateStatusSeparacao(idMov: order.id, status: order.statusSepOrder);
    await sqlConnection.tryConnected(connectionController.connection);
    if (sqlConnection.isConnected) {
      Map<String, dynamic> result = jsonDecode(await sqlConnection.mssqlConnection.writeData(query));
      return MssqlExecuteQueryResult.success(result);
    } else {
      return MssqlExecuteQueryResult.error('Não foi possível conectar ao servidor do Cronos por favor tente novamente.');
    }
  }

  Future<void> disconnectMssql() async {
    await sqlConnection.mssqlConnection.disconnect();
  }
}
