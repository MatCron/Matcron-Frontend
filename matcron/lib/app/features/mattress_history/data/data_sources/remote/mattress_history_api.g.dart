part of 'mattress_history_api_service.dart';

class _MattressHistoryApiService implements MattressHistoryApiService {
  _MattressHistoryApiService(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  }) {
    baseUrl ??= 'https://api.matcron.online/api/mattress';
  }

  final Dio _dio;
  String? baseUrl;
  final ParseErrorLogger? errorLogger;


  @override
  Future<HttpResponse<List<MattressHistoryModel>>> getMattressHistory({required String token, required String id}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;

    final _options = _setStreamType<HttpResponse<List<MattressHistoryModel>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));

    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late List<MattressHistoryModel> _value;

    try {
      _value = _result.data!['data'].map((dynamic i) => MattressHistoryModel.fromJson(i as Map<String, dynamic>))
      .toList()
      .cast<MattressHistoryModel>();
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
}