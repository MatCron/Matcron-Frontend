// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _GroupApiService implements GroupApiService {
  _GroupApiService(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  }) {
    baseUrl ??= 'https://www.matcron.online/api/groups';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<HttpResponse<GroupModel>> getImportPreviewFromMattressId({
    required String id,
    required String token,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<GroupModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/import-preview/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GroupModel _value;
    try {
      _value = GroupModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }

  @override
  Future<HttpResponse<void>> importMattressFromGroup({
    required String id,
    required String token,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;

    final _options = _setStreamType<HttpResponse<void>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/import-mattresses/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));

    final _result = await _dio.fetch<void>(_options);
    return HttpResponse(null, _result);
  }

  @override
  Future<HttpResponse<List<GroupModel>>> getGroups(
      {required int groupStatus, required String token}) async {
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Authorization': token};
    final _data = {"groupStatus": groupStatus};
    
    final _options = Options(
      method: 'POST',
      headers: _headers,
    ).compose(
      _dio.options,
      '/group-by-status',
      queryParameters: queryParameters,
      data: _data,
    ).copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl);
    
    final _result = await _dio.fetch<List<dynamic>>(_options);
    final List<GroupModel> _value =
        _result.data!.map((dynamic i) => GroupModel.fromJson(i as Map<String, dynamic>)).toList();
    return HttpResponse(_value, _result);
  }

  @override
  Future<HttpResponse<GroupModel>> createGroup({
    required CreateGroupModel model,
    required String token,
  }) async {
    final _headers = {'Authorization': token};
    final _data = model.toJson();
    final _options = Options(
      method: 'POST',
      headers: _headers,
    ).compose(
      _dio.options,
      '/add',
      data: _data,
    ).copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl);

    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    final _value = GroupModel.fromJson(_result.data!['group']);
    return HttpResponse(_value, _result);
  }

  @override
  Future<HttpResponse<void>> transferOut({
    required String id,
    required String token,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;

    final _options = _setStreamType<HttpResponse<void>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/transfer-out/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));

    final _result = await _dio.fetch<void>(_options);
    return HttpResponse(null, _result);
  }
}
