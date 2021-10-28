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
        title: json['bookName'],
        author: json['author'] ?? 'no author available',
        category: json['category'] ?? 'unknown',
        bookPath: json['bookFile'] ?? '',
        coverArt: json['imagePath'] != null
            ? Uri.http('www.marakigebeya.com.et', json['imagePath']).toString()
            : 'https://image.freepik.com/free-psd/top-view-book-coffee-cup-arrangement_23-2149040132.jpg',
        narattor: json['narrator'] ?? 'No narattor',
        publishmentYear: json['publicationYear'] ?? '?',
        description: json['description'] ?? 'No description yet',
        resourceType: json['resourceType'] ?? 'not specified',
      );
}
