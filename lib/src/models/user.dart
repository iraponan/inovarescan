import 'package:inovarescan/src/helpers/paser_server/column_tables.dart';
import 'package:inovarescan/src/models/company.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class User {
  String? id;
  String? token;
  String? fullName;
  String? password;
  String? email;
  String? userCronos;
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
    this.userCronos,
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
      userCronos: parseUser.get<String>(UserColumnNamesParseServer.userCronos),
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

  factory User.fromParseObject(ParseObject object) {
    return User(
      id: object.objectId,
      token: '',
      fullName: object.get<String>(UserColumnNamesParseServer.fullName),
      email: object.get<String>(UserColumnNamesParseServer.email),
      userCronos: object.get<String>(UserColumnNamesParseServer.userCronos),
      cpf: object.get<String>(UserColumnNamesParseServer.cpf),
      phone: object.get<String>(UserColumnNamesParseServer.phone),
      company: Company.fromParserObject(object.get(UserColumnNamesParseServer.company)),
      active: object.get<bool>(UserColumnNamesParseServer.active),
      updateAt: object.get<DateTime>(UserColumnNamesParseServer.updateAt),
      createAt: object.get<DateTime>(UserColumnNamesParseServer.createAt),
      emailVerified: object.get<bool>(UserColumnNamesParseServer.emailVerified),
      address: object.get<String>(UserColumnNamesParseServer.address),
      number: object.get<String>(UserColumnNamesParseServer.number),
      neighbourhood: object.get<String>(UserColumnNamesParseServer.neighbourhood),
      complement: object.get<String>(UserColumnNamesParseServer.complement),
      city: object.get<String>(UserColumnNamesParseServer.city),
      state: object.get<String>(UserColumnNamesParseServer.state),
      postCode: object.get<String>(UserColumnNamesParseServer.postCode),
    );
  }

  @override
  String toString() {
    return 'User{id: $id, token: $token, fullName: $fullName, password: $password, email: $email, userCronos: $userCronos, cpf: $cpf, phone: $phone, company: $company,'
        ' active: $active, updateAt: $updateAt, createAt: $createAt, emailVerified: $emailVerified, address: $address, number: $number, neighbourhood: $neighbourhood,'
        ' complement: $complement, city: $city, state: $state, postCode: $postCode}';
  }
}
