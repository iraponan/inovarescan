// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['IdMov'] as num).toInt(),
      typeMov: json['TipoMov'] as String,
      statusSepOrder: json['StatusSepMov'] as String,
      dscStatusSepMov: json['DscStatusSepMov'] as String,
      numMov: json['NumMov'] as String,
      codClient: json['CodigoCliente'] as String,
      nameClient: json['NomeCliente'] as String?,
      razClient: json['RazaoCliente'] as String?,
      cpfCNPJClient: json['CNPJCliente'] as String?,
      dateMov: DateTime.parse(json['DataMov'] as String),
      vendor: json['Vendedor'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'IdMov': instance.id,
      'TipoMov': instance.typeMov,
      'StatusSepMov': instance.statusSepOrder,
      'DscStatusSepMov': instance.dscStatusSepMov,
      'NumMov': instance.numMov,
      'CodigoCliente': instance.codClient,
      'NomeCliente': instance.nameClient,
      'RazaoCliente': instance.razClient,
      'CNPJCliente': instance.cpfCNPJClient,
      'DataMov': instance.dateMov.toIso8601String(),
      'Vendedor': instance.vendor,
    };
