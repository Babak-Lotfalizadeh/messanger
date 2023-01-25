class ResponseAPI<T> {
  dynamic response;
  String? error;

  ResponseAPI.success({
    required this.response,
  });

  ResponseAPI.error({
    required this.error,
  });

  void fold({
    void Function(T)? whenSuccess,
    void Function(String)? whenError,
  }) {
    if (error != null) {
      return whenError?.call(error ?? "");
    }

    if (response != null) {
      return whenSuccess?.call(response as T);
    }
  }
}
