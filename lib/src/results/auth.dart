import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inovarescan/src/models/user.dart';

part 'auth.freezed.dart';

@freezed
class AuthResult with _$AuthResult {
  factory AuthResult.success(User user) = Success;
  factory AuthResult.error(String message) = Error;
}
