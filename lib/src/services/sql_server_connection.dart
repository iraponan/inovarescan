import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/models/connection.dart';
import 'package:mssql_connection/mssql_connection.dart';

class SqlServerConnection extends GetxService {
  final MssqlConnection mssqlConnection = MssqlConnection.getInstance();

  bool get isConnected => mssqlConnection.isConnected;

  Future<void> tryConnected(Connection company) async {
    if (company.id.isNotEmpty) {
      try {
        await mssqlConnection.connect(
          ip: company.server,
          port: company.port,
          databaseName: company.dataBase,
          username: company.username,
          password: company.password,
        );
      } catch (e) {
        Utils.showToast(message: e.toString(), isError: true);
      }
    }
  }
}
