import 'package:inovarescan/src/helpers/paser_server/column_tables.dart';
import 'package:inovarescan/src/helpers/paser_server/tables.dart';
import 'package:inovarescan/src/helpers/utils/parse_erros.dart';
import 'package:inovarescan/src/models/company.dart';
import 'package:inovarescan/src/models/user.dart';
import 'package:inovarescan/src/results/company.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CompanyRepository {
  Future<CompanyResult<List<Company>>> getAllCompanies() async {
    final QueryBuilder queryBuilder = QueryBuilder(ParseObject(TablesNamesParseServer.company))
      ..whereEqualTo(
        CompanyColumnNamesParseServer.active,
        true,
      )
      ..orderByAscending(CompanyColumnNamesParseServer.name);

    final response = await queryBuilder.query();

    if (response.success) {
      List<Company> companies = response.results?.map((c) => Company.fromParserObject(c)).toList() ?? [];
      return CompanyResult<List<Company>>.success(companies);
    } else {
      return CompanyResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }

  Future<CompanyResult<Company>> getCompanyFromCNPJ(String cnpj) async {
    final QueryBuilder queryBuilder = QueryBuilder(ParseObject(TablesNamesParseServer.company))
      ..whereEqualTo(
        CompanyColumnNamesParseServer.cnpj,
        cnpj,
      );

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      return CompanyResult<Company>.success(Company.fromParserObject(response.results?.first));
    }
    if (response.results == null) {
      return CompanyResult.error('');
    } else {
      return CompanyResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }

  Future<CompanyResult<Company>> getCompanyFromUser(User user) async {
    final QueryBuilder queryBuilder = QueryBuilder(ParseObject(TablesNamesParseServer.company))
      ..whereEqualTo(
        CompanyColumnNamesParseServer.id,
        user.company?.id,
      );

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      return CompanyResult<Company>.success(Company.fromParserObject(response.results?.first));
    }
    if (response.results == null) {
      return CompanyResult.error('');
    } else {
      return CompanyResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }
}
