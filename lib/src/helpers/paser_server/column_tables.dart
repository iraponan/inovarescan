mixin UserColumnNamesParseServer {
  static const String id = 'objectId';
  static const String username = 'username';
  static const String fullName = 'nomeCompleto';
  static const String password = 'password';
  static const String email = 'email';
  static const String userCronos = 'userCronos';
  static const String cpf = 'CPF';
  static const String phone = 'telefone';
  static const String company = 'empresa';
  static const String active = 'ativo';
  static const String updateAt = 'updateAt';
  static const String createAt = 'createAt';
  static const String emailVerified = 'emailVerified';
  static const String address = 'endereco';
  static const String number = 'numero';
  static const String neighbourhood = 'bairro';
  static const String complement = 'complemento';
  static const String city = 'cidade';
  static const String state = 'estado';
  static const String postCode = 'CEP';
}

mixin CompanyConnectionColumnNamesParseServer {
  static const String id = 'objectId';
  static const String name = 'nome';
  static const String cnpj = 'CGC';
  static const String server = 'servidor';
  static const String port = 'porta';
  static const String dataBase = 'bancoDeDados';
  static const String username = 'usuario';
  static const String password = 'senha';
  static const String active = 'ativa';
  static const String updateAt = 'updateAt';
  static const String createAt = 'createAt';
}
