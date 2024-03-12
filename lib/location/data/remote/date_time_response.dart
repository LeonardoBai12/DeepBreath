class DateTimeResponse {
  String utc;
  String local;

  DateTimeResponse({
    required this.utc,
    required this.local,
  });

  factory DateTimeResponse.fromJson(Map<String, dynamic> json) {
    return DateTimeResponse(
      utc: json['utc'],
      local: json['local'],
    );
  }
}
