import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T ? data = null;
  final DioException ? error = null;

  const DataState({data, error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super (error: error);
}
