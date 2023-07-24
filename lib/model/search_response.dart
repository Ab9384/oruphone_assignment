class SearchResponse {
  final List<String>? makes;
  final List<String>? models;
  final String? message;

  SearchResponse({
    this.makes,
    this.models,
    this.message,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      makes: List<String>.from(json['makes']),
      models: List<String>.from(json['models']),
      message: json['message'] ?? '',
    );
  }
}
