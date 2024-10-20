import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_email.freezed.dart';

@freezed
class ValidateEmailResult with _$ValidateEmailResult {
  factory ValidateEmailResult.success() = Success;
  factory ValidateEmailResult.error(String message) = Error;
}
