import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inovarescan/src/helpers/mssql/querys_columns.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';

part 'order_items.g.dart';

@JsonSerializable()
class OrderItems {
  @JsonKey(name: QueryOrderItemsColumnsNames.idMov)
  int idMov;
  @JsonKey(name: QueryOrderItemsColumnsNames.idItemMov)
  int idItemMov;
  @JsonKey(name: QueryOrderItemsColumnsNames.image)
  @Uint8ListConverter()
  Uint8List? image;
  @JsonKey(name: QueryOrderItemsColumnsNames.productCod)
  String productCod;
  @JsonKey(name: QueryOrderItemsColumnsNames.productReference)
  String productReference;
  @JsonKey(name: QueryOrderItemsColumnsNames.productName)
  String productName;
  @JsonKey(name: QueryOrderItemsColumnsNames.productManufacturer)
  String productManufacturer;
  @JsonKey(name: QueryOrderItemsColumnsNames.productGroup)
  String productGroup;
  @JsonKey(name: QueryOrderItemsColumnsNames.productStorageLocation)
  String productStorageLocation;
  @JsonKey(name: QueryOrderItemsColumnsNames.productStandardUnit)
  String productStandardUnit;
  @JsonKey(name: QueryOrderItemsColumnsNames.salesUnit)
  String salesUnit;
  @JsonKey(name: QueryOrderItemsColumnsNames.conversionFactor)
  double conversionFactor;
  @JsonKey(name: QueryOrderItemsColumnsNames.qttRequested)
  double qttRequested;
  @JsonKey(name: QueryOrderItemsColumnsNames.qttInvoiced)
  double qttInvoiced;
  @JsonKey(name: QueryOrderItemsColumnsNames.qttSeparate)
  double qttSeparate;
  @JsonKey(name: QueryOrderItemsColumnsNames.currentBalance)
  double currentBalance;
  @BoolIntConverter()
  @JsonKey(name: QueryOrderItemsColumnsNames.hasAGrid)
  bool hasAGrid;
  @BoolIntConverter()
  @JsonKey(name: QueryOrderItemsColumnsNames.hasASerialNumber)
  bool hasASerialNumber;
  @BoolIntConverter()
  @JsonKey(name: QueryOrderItemsColumnsNames.hasABatchNumber)
  bool hasABatchNumber;

  OrderItems(
      {required this.idMov,
      required this.idItemMov,
      this.image,
      required this.productCod,
      this.productReference = '',
      required this.productName,
      required this.productManufacturer,
      required this.productGroup,
      this.productStorageLocation = '',
      required this.productStandardUnit,
      required this.salesUnit,
      required this.conversionFactor,
      this.qttRequested = 0,
      required this.qttInvoiced,
      this.qttSeparate = 0,
      this.currentBalance = 0,
      this.hasAGrid = false,
      this.hasASerialNumber = false,
      this.hasABatchNumber = false});

  factory OrderItems.fromJson(Map<String, dynamic> json) => _$OrderItemsFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemsToJson(this);

  @override
  String toString() {
    return 'OrderItems{idMov: $idMov, idItemMov: $idItemMov, image: $image, productCod: $productCod, productReference: $productReference, productName: $productName,'
        ' productManufacturer: $productManufacturer, productGroup: $productGroup, productStorageLocation: $productStorageLocation, productStandardUnit: $productStandardUnit,'
        ' salesUnit: $salesUnit, conversionFactor: $conversionFactor, qttRequested: $qttRequested, qttInvoiced: $qttInvoiced, qttSeparate: $qttSeparate,'
        ' currentBalance: $currentBalance, hasAGrid: $hasAGrid, hasASerialNumber: $hasASerialNumber, hasABatchNumber: $hasABatchNumber}';
  }
}
