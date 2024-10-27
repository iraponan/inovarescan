import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inovarescan/src/helpers/mssql/querys_columns.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: QueryOrdersColumnsNames.id)
  int id;
  @JsonKey(name: QueryOrdersColumnsNames.typeMov)
  String typeMov;
  @JsonKey(name: QueryOrdersColumnsNames.statusSepMov)
  String statusSepMov;
  @JsonKey(name: QueryOrdersColumnsNames.numMov)
  String numMov;
  @JsonKey(name: QueryOrdersColumnsNames.codClient)
  String codClient;
  @JsonKey(name: QueryOrdersColumnsNames.nameClient)
  String nameClient;
  @JsonKey(name: QueryOrdersColumnsNames.razClient)
  String razClient;
  @JsonKey(name: QueryOrdersColumnsNames.cpfCNPJClient)
  String cpfCNPJClient;
  @JsonKey(name: QueryOrdersColumnsNames.dateMov)
  DateTime dateMov;
  @JsonKey(name: QueryOrdersColumnsNames.vendor)
  String vendor;

  Order({
    required this.id,
    required this.typeMov,
    required this.statusSepMov,
    required this.numMov,
    required this.codClient,
    required this.nameClient,
    required this.razClient,
    required this.cpfCNPJClient,
    required this.dateMov,
    required this.vendor,
  });

  @override
  String toString() {
    return 'Order{id: $id, typeMov: $typeMov, statusSepMov: $statusSepMov, numMov: $numMov, codClient: $codClient, nameClient: $nameClient, razClient: $razClient, cpfCNPJClient: $cpfCNPJClient, dateMov: $dateMov, vendor: $vendor}';
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
