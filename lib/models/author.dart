class Author {
  final String id, name, authorImage;

  Author({
    required this.id,
    required this.name,
    required this.authorImage,
  });

  factory Author.fromMap(Map<String, dynamic> json) => Author(
        id: json['id'],
        name: json['name'],
        authorImage:
            Uri.http('www.marakigebeya.com.et', json['authorImage']).toString(),
      );
}
