import 'package:freezed_annotation/freezed_annotation.dart';

part 'company.freezed.dart';

@freezed
class CompanyResult<T> with _$CompanyResult<T> {
  factory CompanyResult.success(T data) = Success;
  factory CompanyResult.error(String message) = Error;
}
