import 'dart:typed_data';

class Book {
  final String id,
      title,
      author,
      authorId,
      category,
      coverArt,
      narattor,
      edition,
      bookPath,
      description,
      publishmentYear,
      resourceType;
  final double? priceEtb, priceUSD;
  final List<Uint8List>? episodes;

  Book({
    required this.id,
    required this.bookPath,
    required this.narattor,
    required this.coverArt,
    required this.category,
    required this.title,
    required this.edition,
    required this.author,
    required this.authorId,
    required this.publishmentYear,
    required this.description,
    required this.resourceType,
    required this.priceEtb,
    required this.priceUSD,
    this.episodes,
  });

  factory Book.fromMap(Map<String, dynamic> json) => Book(
        id: json['id'],
        title: json['bookName'],
        author: json['author'] ?? 'no author available',
        authorId: json['authorId'] ?? 'no author available',
        edition: json['edition'] ?? '1',
        category: json['category'] ?? 'unknown',
        bookPath: json['bookFile'] ?? '',
        coverArt: json['imagePath'] != null
            ? Uri.http('www.marakigebeya.com.et', json['imagePath']).toString()
            : 'https://image.freepik.com/free-psd/top-view-book-coffee-cup-arrangement_23-2149040132.jpg',
        narattor: json['narrator'] ?? 'No narattor',
        publishmentYear: json['publicationYear'] ?? '?',
        description: json['description'] ?? 'No description yet',
        resourceType: json['resourceType'] ?? 'not specified',
        priceEtb: json['priceEtb'].toDouble() ?? 0,
        priceUSD: json['priceUSD'].toDouble() ?? 0,
      );
}
