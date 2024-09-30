import 'package:inovarescan/src/helpers/paser_server_consts/column_tables.dart';
import 'package:inovarescan/src/models/company.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class User {
  String? id;
  String? token;
  String? fullName;
  String? password;
  String? email;
  String? cpf;
  String? phone;
  Company? company;
  bool? active;
  DateTime? updateAt;
  DateTime? createAt;
  bool? emailVerified;
  String? address;
  String? number;
  String? neighbourhood;
  String? complement;
  String? city;
  String? state;
  String? postCode;

  User({
    this.id,
    this.token,
    this.fullName,
    this.password,
    this.email,
    this.cpf,
    this.phone,
    this.company,
    this.active,
    this.updateAt,
    this.createAt,
    this.emailVerified,
    this.address,
    this.number,
    this.neighbourhood,
    this.complement,
    this.city,
    this.state,
    this.postCode,
  });

  factory User.fromParseUser(ParseUser parseUser) {
    return User(
      id: parseUser.objectId,
      token: parseUser.sessionToken,
      fullName: parseUser.get<String>(UserColumnNamesParseServer.fullName),
      email: parseUser.emailAddress,
      cpf: parseUser.get<String>(UserColumnNamesParseServer.cpf),
      phone: parseUser.get<String>(UserColumnNamesParseServer.phone),
      company: Company.fromParserObject(parseUser.get(UserColumnNamesParseServer.company)),
      active: parseUser.get<bool>(UserColumnNamesParseServer.active),
      updateAt: parseUser.get<DateTime>(UserColumnNamesParseServer.updateAt),
      createAt: parseUser.get<DateTime>(UserColumnNamesParseServer.createAt),
      emailVerified: parseUser.get<bool>(UserColumnNamesParseServer.emailVerified),
      address: parseUser.get<String>(UserColumnNamesParseServer.address),
      number: parseUser.get<String>(UserColumnNamesParseServer.number),
      neighbourhood: parseUser.get<String>(UserColumnNamesParseServer.neighbourhood),
      complement: parseUser.get<String>(UserColumnNamesParseServer.complement),
      city: parseUser.get<String>(UserColumnNamesParseServer.city),
      state: parseUser.get<String>(UserColumnNamesParseServer.state),
      postCode: parseUser.get<String>(UserColumnNamesParseServer.postCode),
    );
  }

  @override
  String toString() {
    return 'User{id: $id, fullName: $fullName, email: $email, phone: $phone, company: $company, active: $active, updateAt: $updateAt, createAt: $createAt,'
        ' emailVerified: $emailVerified, address: $address, number: $number, neighbourhood: $neighbourhood, complement: $complement, city: $city, state: $state, postCode: $postCode}';
  }
}
