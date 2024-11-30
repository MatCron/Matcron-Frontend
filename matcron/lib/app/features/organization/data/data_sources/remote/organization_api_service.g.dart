// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _OrganizationApiService implements OrganizationApiService {
  _OrganizationApiService(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  }) {
    baseUrl ??= 'http://192.168.1.17:8080/api/organization';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<HttpResponse<List<OrganizationModel>>> getOrganizations() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<HttpResponse<List<OrganizationModel>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/organizations',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<List<dynamic>>(_options);
    late List<OrganizationModel> _value;
    try {
      _value = _result.data!
          .map((dynamic i) =>
              OrganizationModel.fromJson(i as Map<String, dynamic>))
          .toList();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<void>> addOrganization(
      {required OrganizationModel model}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(model.toJson());
    final _options = _setStreamType<HttpResponse<void>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/organizations/add',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<void>(_options);
    final httpResponse = HttpResponse(null, _result);
    return httpResponse;
  }

  // @override
  // Future<HttpResponse<void>> update({required String id}) async {
  //   final _extra = <String, dynamic>{};
  //   final queryParameters = <String, dynamic>{};
  //   final _headers = <String, dynamic>{};
  //   final _data = id;
  //   final _options = _setStreamType<HttpResponse<void>>(Options(
  //     method: 'POST',
  //     headers: _headers,
  //     extra: _extra,
  //   )
  //       .compose(
  //         _dio.options,
  //         '/organizations/update',
  //         queryParameters: queryParameters,
  //         data: _data,
  //       )
  //       .copyWith(
  //           baseUrl: _combineBaseUrls(
  //         _dio.options.baseUrl,
  //         baseUrl,
  //       )));
  //   final _result = await _dio.fetch<void>(_options);
  //   final httpResponse = HttpResponse(null, _result);
  //   return httpResponse;
  // }

  @override
  Future<HttpResponse<void>> delete({required String id}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = id;
    final _options = _setStreamType<HttpResponse<void>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/organizations/delete',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<void>(_options);
    final httpResponse = HttpResponse(null, _result);
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
}
