import 'dart:convert';

import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/company.dart';
import 'package:inovarescan/src/helpers/mssql/querys.dart';
import 'package:inovarescan/src/results/mssql_execute_query.dart';
import 'package:inovarescan/src/services/sql_server_connection.dart';

class OrderRepository {
  SqlServerConnection sqlConnection = Get.find<SqlServerConnection>();
  final companyController = Get.find<CompanyController>();

  Future<MssqlExecuteQueryResult<List<dynamic>>> getOrders({required String typeData, DateTime? dateIni, DateTime? dateEnd, required int page, required int itemsPerPage}) async {
    String query = QuerysCronos.selectPedidos(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd, page: page, itemsPerPage: itemsPerPage);
    await sqlConnection.tryConnected(companyController.company);
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
