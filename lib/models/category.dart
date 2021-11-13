class Category {
  String id, name;
  int status;

  Category({
    required this.id,
    required this.name,
    required this.status,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json['id'] ?? '?',
        name: json['name'] ?? '?',
        status: json['status'] ?? 0,
      );
}
