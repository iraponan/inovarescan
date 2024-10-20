import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/company.dart';
import 'package:inovarescan/src/helpers/mssql/querys.dart';
import 'package:inovarescan/src/services/sql_server_connection.dart';

class HomeDataCronosRepository {
  SqlServerConnection sqlConnection = Get.find<SqlServerConnection>();
  final companyController = Get.find<CompanyController>();

  Future<Map<String, dynamic>> getDataFromCronos({DateTime? dateIni, DateTime? dateEnd}) async {
    log(companyController.company.toString());
    await sqlConnection.tryConnected(companyController.company);
    String query = QuerysCronos.selectPercSeparado(dateIni: dateIni, dateEnd: dateEnd);
    List<dynamic> result = jsonDecode(await sqlConnection.mssqlConnection.getData(query));
    return result.first;
  }
}
