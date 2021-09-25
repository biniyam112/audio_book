class Book {
  final String title,
      author,
      category,
      coverArt,
      narattor,
      bookPath,
      description;
  final double duration;
  final int id, chapersCount;
  final DateTime publishmentYear;

  Book({
    required this.id,
    required this.bookPath,
    required this.narattor,
    required this.coverArt,
    required this.category,
    required this.title,
    required this.author,
    required this.duration,
    required this.publishmentYear,
    required this.chapersCount,
    required this.description,
  });

  factory Book.fromMap(Map<String, dynamic> json) => Book(
        id: json['id'],
        title: json['name'],
        author: json['author']['name'],
        category: json['category']['name'],
        bookPath: json[''],
        chapersCount: json[''],
        coverArt: json['coverArt'],
        duration: json[''],
        narattor: json['narrator'],
        publishmentYear: json['publicationYear'],
        description: json['description'],
      );
}

List<Book> libraryMockData = [
  Book(
    id: 0,
    title: "Different Winter",
    author: "Mia Jackson",
    category: "History",
    bookPath:
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
    coverArt:
        "https://image.freepik.com/free-psd/high-angle-turned-open-book-mock-up_23-2148657114.jpg",
    chapersCount: 4,
    duration: 120,
    publishmentYear: DateTime.now(),
    narattor: 'Abreham Mulatu',
    description: '',
  ),
  Book(
    id: 1,
    title: "Hideout",
    author: "Ishikawa",
    category: "Fantasy",
    bookPath:
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
    coverArt:
        "https://image.freepik.com/free-vector/green-commercial-annual-report-template_1201-1061.jpg",
    chapersCount: 4,
    duration: 45,
    publishmentYear: DateTime.now(),
    narattor: 'Dagnachew Hagere',
    description: '',
  ),
  Book(
    id: 2,
    title: "The Price",
    author: "Machiavelli",
    category: "Politics",
    bookPath: 'http://www.africau.edu/images/default/sample.pdf',
    coverArt:
        "https://image.freepik.com/free-psd/book-cover-mockup_400875-79.jpg",
    chapersCount: 32,
    duration: 12,
    publishmentYear: DateTime.now(),
    narattor: 'Admasu Kibru',
    description: '',
  ),
  Book(
    id: 3,
    title: "The Value of Design",
    author: "Mia Jackson",
    category: "Art",
    bookPath: 'http://www.africau.edu/images/default/sample.pdf',
    coverArt:
        "https://cdn.pixabay.com/photo/2019/04/12/14/37/fantasy-4122305_960_720.jpg",
    chapersCount: 12,
    duration: 34,
    publishmentYear: DateTime.now(),
    narattor: 'Sisay Girma',
    description: '',
  ),
];
List<Book> libraryMockDataPolitics = [
  Book(
    id: 4,
    title: "Different Winter",
    author: "Mia Jackson",
    category: "History",
    bookPath:
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
    coverArt:
        "https://image.freepik.com/free-psd/high-angle-turned-open-book-mock-up_23-2148657114.jpg",
    chapersCount: 4,
    duration: 120,
    publishmentYear: DateTime.now(),
    narattor: 'Abreham Mulatu',
    description: '',
  ),
  Book(
    id: 5,
    title: "Hideout",
    author: "Ishikawa",
    category: "Fantasy",
    bookPath:
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
    coverArt:
        "https://image.freepik.com/free-vector/green-commercial-annual-report-template_1201-1061.jpg",
    chapersCount: 4,
    duration: 45,
    publishmentYear: DateTime.now(),
    narattor: 'Dagnachew Hagere',
    description: '',
  ),
  Book(
    id: 6,
    title: "The Price",
    author: "Machiavelli",
    category: "Politics",
    bookPath: 'http://www.africau.edu/images/default/sample.pdf',
    coverArt:
        "https://image.freepik.com/free-psd/book-cover-mockup_400875-79.jpg",
    chapersCount: 32,
    duration: 12,
    publishmentYear: DateTime.now(),
    narattor: 'Admasu Kibru',
    description: '',
  ),
  Book(
    id: 7,
    title: "The Value of Design",
    author: "Mia Jackson",
    category: "Art",
    bookPath: 'http://www.africau.edu/images/default/sample.pdf',
    coverArt:
        "https://cdn.pixabay.com/photo/2019/04/12/14/37/fantasy-4122305_960_720.jpg",
    chapersCount: 12,
    duration: 34,
    publishmentYear: DateTime.now(),
    narattor: 'Sisay Girma',
    description: '',
  ),
];
List<Book> libraryMockDataRomance = [
  Book(
    id: 8,
    title: "Different Winter",
    author: "Mia Jackson",
    category: "History",
    bookPath:
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
    coverArt:
        "https://image.freepik.com/free-psd/high-angle-turned-open-book-mock-up_23-2148657114.jpg",
    chapersCount: 4,
    duration: 120,
    publishmentYear: DateTime.now(),
    narattor: 'Abreham Mulatu',
    description: '',
  ),
  Book(
    id: 9,
    title: "Hideout",
    author: "Ishikawa",
    category: "Fantasy",
    bookPath:
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
    coverArt:
        "https://image.freepik.com/free-vector/green-commercial-annual-report-template_1201-1061.jpg",
    chapersCount: 4,
    duration: 45,
    publishmentYear: DateTime.now(),
    narattor: 'Dagnachew Hagere',
    description: '',
  ),
  Book(
    id: 10,
    title: "The Price",
    author: "Machiavelli",
    category: "Politics",
    bookPath: 'http://www.africau.edu/images/default/sample.pdf',
    coverArt:
        "https://image.freepik.com/free-psd/book-cover-mockup_400875-79.jpg",
    chapersCount: 32,
    duration: 12,
    publishmentYear: DateTime.now(),
    narattor: 'Admasu Kibru',
    description: '',
  ),
  Book(
    id: 11,
    title: "The Value of Design",
    author: "Mia Jackson",
    category: "Art",
    bookPath: 'http://www.africau.edu/images/default/sample.pdf',
    coverArt:
        "https://cdn.pixabay.com/photo/2019/04/12/14/37/fantasy-4122305_960_720.jpg",
    chapersCount: 12,
    duration: 34,
    publishmentYear: DateTime.now(),
    narattor: 'Sisay Girma',
    description: '',
  ),
];
