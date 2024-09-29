import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inovarescan/src/models/company.dart';

part 'company.freezed.dart';

@freezed
class CompanyResult with _$CompanyResult {
  factory CompanyResult.success(Company company) = Success;
  factory CompanyResult.error(String message) = Error;
}
