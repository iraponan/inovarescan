import 'package:freezed_annotation/freezed_annotation.dart';

part 'mssql_execute_query.freezed.dart';

@freezed
class MssqlExecuteQueryResult<T> with _$MssqlExecuteQueryResult<T> {
  factory MssqlExecuteQueryResult.success(T data) = Success;
  factory MssqlExecuteQueryResult.error(String message) = Error;
}
