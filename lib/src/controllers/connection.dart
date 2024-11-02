import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/models/connection.dart';
import 'package:inovarescan/src/models/user.dart';
import 'package:inovarescan/src/repositories/parse_server/connection.dart';
import 'package:inovarescan/src/results/connection.dart';

class ConnectionController extends GetxController {
  final ConnectionRepository _connectionRepository = ConnectionRepository();

  List<Connection> connections = [];
  Connection connection = Connection();

  Future<void> gelAllConnectionCompanies() async {
    ConnectionResult<List<Connection>> result = await _connectionRepository.getAllConnectionCompanies();

    result.when(
      success: (connections) {
        this.connections = connections;
      },
      error: (message) {
        if (message.isNotEmpty) {
          Utils.showToast(message: message, isError: true);
        }
      },
    );
  }

  Future<bool> getCompanyFromCNPJ(String cnpj) async {
    ConnectionResult<Connection> result = await _connectionRepository.getCompanyFromCNPJ(cnpj);
    result.when(
      success: (connection) {
        this.connection = connection;
      },
      error: (message) {
        if (message.isNotEmpty) {
          Utils.showToast(message: message, isError: true);
        }
      },
    );
    return connection.id.isNotEmpty;
  }

  Future<bool> getCompanyFromUser(User user) async {
    ConnectionResult<Connection> result = await _connectionRepository.getCompanyFromUser(user);
    result.when(
      success: (connection) {
        this.connection = connection;
      },
      error: (message) {
        if (message.isNotEmpty) {
          Utils.showToast(message: message, isError: true);
        }
      },
    );
    return connection.id.isNotEmpty;
  }
}
