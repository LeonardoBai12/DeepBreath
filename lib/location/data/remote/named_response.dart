class NamedResponse {
  String name;

  NamedResponse({
    required this.name,
  });

  factory NamedResponse.fromJson(Map<String, dynamic> json) {
    return NamedResponse(
      name: json['name'],
    );
  }
}