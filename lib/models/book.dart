class Book {
  final String id,
      title,
      author,
      category,
      coverArt,
      narattor,
      bookPath,
      description,
      publishmentYear,
      resourceType;

  Book({
    required this.id,
    required this.bookPath,
    required this.narattor,
    required this.coverArt,
    required this.category,
    required this.title,
    required this.author,
    required this.publishmentYear,
    required this.description,
    required this.resourceType,
  });

  factory Book.fromMap(Map<String, dynamic> json) => Book(
        id: json['id'],
        title: json['name'],
        author: json['author']['name'],
        category: json['category']['name'],
        bookPath: json['id'],
        coverArt: json['coverArt'] ?? 'assets/images/book_0.jpg',
        narattor: json['narrator'] ?? 'No narattor',
        publishmentYear: json['publicationYear'] ?? '?',
        description: json['description'] ?? 'No description yet',
        resourceType: json['resourceType'],
      );
}
