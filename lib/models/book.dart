class Book {
  final String title, author, category, coverArt, narattor, bookPath;
  final double duration;
  final int id, chapersCount;
  final DateTime publishmentDate;

  Book({
    required this.id,
    required this.bookPath,
    required this.narattor,
    required this.coverArt,
    required this.category,
    required this.title,
    required this.author,
    required this.duration,
    required this.publishmentDate,
    required this.chapersCount,
  });
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
    publishmentDate: DateTime.now(),
    narattor: 'Abreham Mulatu',
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
    publishmentDate: DateTime.now(),
    narattor: 'Dagnachew Hagere',
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
    publishmentDate: DateTime.now(),
    narattor: 'Admasu Kibru',
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
    publishmentDate: DateTime.now(),
    narattor: 'Sisay Girma',
  ),
];
