import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection.freezed.dart';

@freezed
class ConnectionResult<T> with _$ConnectionResult<T> {
  factory ConnectionResult.success(T data) = Success;
  factory ConnectionResult.error(String message) = Error;
}
