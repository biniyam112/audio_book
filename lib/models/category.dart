class Category {
  String? id, name, status;

  Category({
    required this.id,
    required this.name,
    required this.status,
  });

  factory Category.fromMap(Map<dynamic, String> json) => Category(
        id: json['id'],
        name: json['name'],
        status: json['status'],
      );
}
