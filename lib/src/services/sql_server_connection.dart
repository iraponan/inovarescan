import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/models/connection.dart';
import 'package:mssql_connection/mssql_connection.dart';

class SqlServerConnection extends GetxService {
  final MssqlConnection mssqlConnection = MssqlConnection.getInstance();

  bool get isConnected => mssqlConnection.isConnected;

  Future<void> tryConnected(Connection connection) async {
    if (connection.id.isNotEmpty) {
      try {
        await mssqlConnection.connect(
          ip: connection.server,
          port: connection.port,
          databaseName: connection.dataBase,
          username: connection.username,
          password: connection.password,
        );
      } catch (e) {
        Utils.showToast(message: e.toString(), isError: true);
      }
    }
  }
}
