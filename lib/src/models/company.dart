import 'package:inovarescan/src/helpers/paser_server_consts/column_tables.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Company {
  String? id;
  String? name;
  String? cgc;
  String? server;
  bool? active;
  DateTime? updateAt;
  DateTime? createAt;

  Company({
    this.id,
    this.name,
    this.cgc,
    this.server,
    this.active,
    this.updateAt,
    this.createAt,
  });

  factory Company.fromParserObject(ParseObject object) {
    return Company(
      id: object.objectId,
      name: object.get<String>(CompanyColumnNamesParseServer.name),
      cgc: object.get<String>(CompanyColumnNamesParseServer.cgc),
      server: object.get<String>(CompanyColumnNamesParseServer.server),
      active: object.get<bool>(CompanyColumnNamesParseServer.active),
      updateAt: object.get<DateTime>(CompanyColumnNamesParseServer.updateAt),
      createAt: object.get<DateTime>(CompanyColumnNamesParseServer.createAt),
    );
  }

  @override
  String toString() {
    return 'Company{id: $id, name: $name, cgc: $cgc, server: $server, active: $active, updateAt: $updateAt, createAt: $createAt}';
  }
}
