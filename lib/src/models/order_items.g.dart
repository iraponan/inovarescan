// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItems _$OrderItemsFromJson(Map<String, dynamic> json) => OrderItems(
      idMov: (json['IdMov'] as num).toInt(),
      idItemMov: (json['IdItemMov'] as num).toInt(),
      image: const Uint8ListConverter().fromJson(json['Imagem'] as String?),
      productCod: json['Codigo'] as String,
      productReference: json['Referencia'] as String? ?? '',
      productName: json['Nome'] as String,
      productManufacturer: json['Fabricante'] as String,
      productGroup: json['Grupo'] as String,
      productStorageLocation: json['LocalArmazenamento'] as String? ?? '',
      productStandardUnit: json['UnidPadrao'] as String,
      salesUnit: json['UnidVenda'] as String,
      conversionFactor: (json['Fator'] as num).toDouble(),
      qttRequested: (json['QtdSolicitada'] as num?)?.toDouble() ?? 0,
      qttInvoiced: (json['QtdFaturada'] as num).toDouble(),
      qttSeparate: (json['QtsSeparada'] as num?)?.toDouble() ?? 0,
      currentBalance: (json['SdoAtual'] as num?)?.toDouble() ?? 0,
      hasAGrid: json['PossuiGrade'] == null
          ? false
          : const BoolIntConverter()
              .fromJson((json['PossuiGrade'] as num).toInt()),
      hasASerialNumber: json['PossuiSerie'] == null
          ? false
          : const BoolIntConverter()
              .fromJson((json['PossuiSerie'] as num).toInt()),
      hasABatchNumber: json['PossuiLote'] == null
          ? false
          : const BoolIntConverter()
              .fromJson((json['PossuiLote'] as num).toInt()),
    );

Map<String, dynamic> _$OrderItemsToJson(OrderItems instance) =>
    <String, dynamic>{
      'IdMov': instance.idMov,
      'IdItemMov': instance.idItemMov,
      'Imagem': const Uint8ListConverter().toJson(instance.image),
      'Codigo': instance.productCod,
      'Referencia': instance.productReference,
      'Nome': instance.productName,
      'Fabricante': instance.productManufacturer,
      'Grupo': instance.productGroup,
      'LocalArmazenamento': instance.productStorageLocation,
      'UnidPadrao': instance.productStandardUnit,
      'UnidVenda': instance.salesUnit,
      'Fator': instance.conversionFactor,
      'QtdSolicitada': instance.qttRequested,
      'QtdFaturada': instance.qttInvoiced,
      'QtsSeparada': instance.qttSeparate,
      'SdoAtual': instance.currentBalance,
      'PossuiGrade': const BoolIntConverter().toJson(instance.hasAGrid),
      'PossuiSerie': const BoolIntConverter().toJson(instance.hasASerialNumber),
      'PossuiLote': const BoolIntConverter().toJson(instance.hasABatchNumber),
    };
