import 'package:inovarescan/src/helpers/paser_server/column_tables.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Connection {
  String id;
  String name;
  String cnpj;
  String server;
  String port;
  String dataBase;
  String username;
  String password;
  bool active;
  DateTime? updateAt;
  DateTime? createAt;

  Connection({
    this.id = '',
    this.name = '',
    this.cnpj = '',
    this.server = '',
    this.port = '',
    this.dataBase = '',
    this.username = '',
    this.password = '',
    this.active = false,
    this.updateAt,
    this.createAt,
  });

  factory Connection.fromParserObject(ParseObject object) {
    return Connection(
      id: object.objectId ?? '',
      name: object.get<String>(CompanyConnectionColumnNamesParseServer.name) ?? '',
      cnpj: object.get<String>(CompanyConnectionColumnNamesParseServer.cnpj) ?? '',
      server: object.get<String>(CompanyConnectionColumnNamesParseServer.server) ?? '',
      port: object.get<String>(CompanyConnectionColumnNamesParseServer.port) ?? '',
      dataBase: object.get<String>(CompanyConnectionColumnNamesParseServer.dataBase) ?? '',
      username: object.get<String>(CompanyConnectionColumnNamesParseServer.username) ?? '',
      password: object.get<String>(CompanyConnectionColumnNamesParseServer.password) ?? '',
      active: object.get<bool>(CompanyConnectionColumnNamesParseServer.active) ?? false,
      updateAt: object.get<DateTime>(CompanyConnectionColumnNamesParseServer.updateAt),
      createAt: object.get<DateTime>(CompanyConnectionColumnNamesParseServer.createAt),
    );
  }

  @override
  String toString() {
    return 'Company{id: $id, name: $name, cgc: $cnpj, server: $server, active: $active, updateAt: $updateAt, createAt: $createAt}';
  }
}
