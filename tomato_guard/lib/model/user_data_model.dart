class UserDataModel {
  final String id;
  final String image;
  final String title;
  final String data;

  UserDataModel({
    required this.id,
    required this.image,
    required this.title,
    required this.data,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id:
          json['id']?.toString() ??
          '', // Convert to String and fallback to empty
      image: json['DiseaseImage'] ?? '', // Change key if needed
      title: json['DiseaseName'] ?? 'Unknown', // Default value
      data: json['Date']?.toString() ?? '', // Handle null safely
    );
  }
}
