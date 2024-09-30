import 'package:inovarescan/src/helpers/paser_server_consts/column_tables.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Company {
  String? id;
  String? name;
  String? cnpj;
  String? server;
  String? port;
  String? dataBase;
  String? username;
  String? password;
  bool? active;
  DateTime? updateAt;
  DateTime? createAt;

  Company({
    this.id,
    this.name,
    this.cnpj,
    this.server,
    this.port,
    this.dataBase,
    this.username,
    this.password,
    this.active,
    this.updateAt,
    this.createAt,
  });

  factory Company.fromParserObject(ParseObject object) {
    return Company(
      id: object.objectId,
      name: object.get<String>(CompanyColumnNamesParseServer.name),
      cnpj: object.get<String>(CompanyColumnNamesParseServer.cnpj),
      server: object.get<String>(CompanyColumnNamesParseServer.server),
      port: object.get<String>(CompanyColumnNamesParseServer.port),
      dataBase: object.get<String>(CompanyColumnNamesParseServer.dataBase),
      username: object.get<String>(CompanyColumnNamesParseServer.username),
      password: object.get<String>(CompanyColumnNamesParseServer.password),
      active: object.get<bool>(CompanyColumnNamesParseServer.active),
      updateAt: object.get<DateTime>(CompanyColumnNamesParseServer.updateAt),
      createAt: object.get<DateTime>(CompanyColumnNamesParseServer.createAt),
    );
  }

  @override
  String toString() {
    return 'Company{id: $id, name: $name, cgc: $cnpj, server: $server, active: $active, updateAt: $updateAt, createAt: $createAt}';
  }
}
