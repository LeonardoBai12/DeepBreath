class ManufacturerResponse {
  String modelName;
  String manufacturerName;

  ManufacturerResponse({
    required this.modelName,
    required this.manufacturerName,
  });

  factory ManufacturerResponse.fromJson(Map<String, dynamic> json) {
    return ManufacturerResponse(
      modelName: json['modelName'],
      manufacturerName: json['manufacturerName'],
    );
  }
}
