import 'package:inovarescan/src/helpers/paser_server/column_tables.dart';
import 'package:inovarescan/src/helpers/paser_server/tables.dart';
import 'package:inovarescan/src/helpers/utils/parse_erros.dart';
import 'package:inovarescan/src/models/connection.dart';
import 'package:inovarescan/src/models/user.dart';
import 'package:inovarescan/src/results/connection.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ConnectionRepository {
  Future<ConnectionResult<List<Connection>>> getAllConnectionCompanies() async {
    final QueryBuilder queryBuilder = QueryBuilder(ParseObject(TablesNamesParseServer.company))
      ..whereEqualTo(
        CompanyConnectionColumnNamesParseServer.active,
        true,
      )
      ..orderByAscending(CompanyConnectionColumnNamesParseServer.name);

    final response = await queryBuilder.query();

    if (response.success) {
      List<Connection> companies = response.results?.map((c) => Connection.fromParserObject(c)).toList() ?? [];
      return ConnectionResult<List<Connection>>.success(companies);
    } else {
      return ConnectionResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }

  Future<ConnectionResult<Connection>> getCompanyFromCNPJ(String cnpj) async {
    final QueryBuilder queryBuilder = QueryBuilder(ParseObject(TablesNamesParseServer.company))
      ..whereEqualTo(
        CompanyConnectionColumnNamesParseServer.cnpj,
        cnpj,
      );

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      return ConnectionResult<Connection>.success(Connection.fromParserObject(response.results?.first));
    }
    if (response.results == null) {
      return ConnectionResult.error('');
    } else {
      return ConnectionResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }

  Future<ConnectionResult<Connection>> getCompanyFromUser(User user) async {
    final QueryBuilder queryBuilder = QueryBuilder(ParseObject(TablesNamesParseServer.company))
      ..whereEqualTo(
        CompanyConnectionColumnNamesParseServer.id,
        user.connection?.id,
      );

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      return ConnectionResult<Connection>.success(Connection.fromParserObject(response.results?.first));
    }
    if (response.results == null) {
      return ConnectionResult.error('');
    } else {
      return ConnectionResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }
}
