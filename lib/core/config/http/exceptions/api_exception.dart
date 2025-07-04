class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() {
    final buffer = StringBuffer('ApiException: $message');
    if (statusCode != null) buffer.write(' (Status Code: $statusCode)');
    if (data != null) buffer.write(' | Data: $data');
    return buffer.toString();
  }
}
