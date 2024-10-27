import 'dart:convert';

import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/company.dart';
import 'package:inovarescan/src/helpers/mssql/querys.dart';
import 'package:inovarescan/src/results/mssql_execute_query.dart';
import 'package:inovarescan/src/services/sql_server_connection.dart';

class HomeDataCronosRepository {
  SqlServerConnection sqlConnection = Get.find<SqlServerConnection>();
  final companyController = Get.find<CompanyController>();

  Future<MssqlExecuteQueryResult<Map<String, dynamic>>> getPercQttSeparationsFromCronos({required String typeData, DateTime? dateIni, DateTime? dateEnd}) async {
    String query = QuerysCronos.selectQtdPercSeparacoes(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd);
    await sqlConnection.tryConnected(companyController.company);
    if (sqlConnection.isConnected) {
      List<dynamic> result = jsonDecode(await sqlConnection.mssqlConnection.getData(query));
      return MssqlExecuteQueryResult.success(result.first);
    } else {
      return MssqlExecuteQueryResult.error('Não foi possível conectar ao servidor do Cronos por favor tente novamente.');
    }
  }

  Future<MssqlExecuteQueryResult<List<dynamic>>> getQttBySeparatorFromCronos({required String typeData, DateTime? dateIni, DateTime? dateEnd}) async {
    String query = QuerysCronos.selectQtdPorSeparador(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd);
    await sqlConnection.tryConnected(companyController.company);
    if (sqlConnection.isConnected) {
      List<dynamic> result = jsonDecode(await sqlConnection.mssqlConnection.getData(query));
      return MssqlExecuteQueryResult.success(result);
    } else {
      return MssqlExecuteQueryResult.error('Não foi possível conectar ao servidor do Cronos por favor tente novamente.');
    }
  }

  Future<MssqlExecuteQueryResult<List<dynamic>>> getQttPerHourFromCronos({required String typeData, DateTime? dateIni, DateTime? dateEnd}) async {
    String query = QuerysCronos.selectQtdSeparadaPorHora(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd);
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
