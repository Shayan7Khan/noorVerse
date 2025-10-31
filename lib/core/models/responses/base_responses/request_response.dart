class RequestResponse {
  bool success;
  String? error;
  Map<String, dynamic> data;

  RequestResponse(this.success, {this.error, Map<String, dynamic>? data})
      : data = data ?? {};

  RequestResponse.fromJson(json)
      : success = (json is Map && json['success'] is bool)
            ? (json['success'] as bool)
            : true,
        error = (json is Map) ? (json['error'] as String?) : null,
        data = (json is Map<String, dynamic>) ? json : {'body': json};

  toJson() {
    return {
      'success': success,
      'error': error,
      'body': data,
    };
  }
}
