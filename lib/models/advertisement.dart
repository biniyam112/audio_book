class Advertisement {
  final String id, name, imagePath;

  Advertisement(
      {required this.id, required this.name, required this.imagePath});

  factory Advertisement.fromMap(Map<String, dynamic> json) => Advertisement(
        id: json['id'],
        name: json['name'],
        imagePath:
            Uri.http('www.marakigebeya.com.et', json['imagePath']).toString(),
      );
}
