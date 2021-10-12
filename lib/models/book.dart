class Book {
  final String id,
      title,
      author,
      category,
      coverArt,
      narattor,
      bookPath,
      description,
      publishmentYear;
  final int resourceType;

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
        author: json['author']['name'] ?? 'no author available',
        category: json['category']['name'] ?? 'unknown',
        bookPath: json['bookFile'] ?? '',
        coverArt: json['coverArt'] ??
            'https://image.freepik.com/free-psd/top-view-book-coffee-cup-arrangement_23-2149040132.jpg',
        narattor: json['narrator'] ?? 'No narattor',
        publishmentYear: json['publicationYear'] ?? '?',
        description: json['description'] ?? 'No description yet',
        resourceType: json['resourceType'] ?? 2,
      );
}

List<Book> allBooks = [
  Book(
    id: '0',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/top-view-book-coffee-cup-arrangement_23-2149040132.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
  Book(
    id: '1',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/book-hardcover-mockup-three-views_125540-226.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
  Book(
    id: '2',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/arrangement-mock-up-book-cover_23-2149059351.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
  Book(
    id: '3',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/book-hardcover-mockup-three-views_125540-226.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
];
List<Book> romanceBooks = [
  Book(
    id: '4',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/top-view-book-coffee-cup-arrangement_23-2149040132.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
  Book(
    id: '5',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/book-hardcover-mockup-three-views_125540-226.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
  Book(
    id: '6',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/arrangement-mock-up-book-cover_23-2149059351.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
  Book(
    id: '7',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/book-hardcover-mockup-three-views_125540-226.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
];
List<Book> motivationalBooks = [
  Book(
    id: '8',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/top-view-book-coffee-cup-arrangement_23-2149040132.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
  Book(
    id: '9',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/book-hardcover-mockup-three-views_125540-226.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
  Book(
    id: '10',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/arrangement-mock-up-book-cover_23-2149059351.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
  Book(
    id: '11',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/book-hardcover-mockup-three-views_125540-226.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
];
List<Book> politicsBooks = [
  Book(
    id: '12',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/top-view-book-coffee-cup-arrangement_23-2149040132.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
  Book(
    id: '13',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/book-hardcover-mockup-three-views_125540-226.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
  Book(
    id: '14',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/arrangement-mock-up-book-cover_23-2149059351.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
  Book(
    id: '15',
    bookPath: '',
    narattor: 'Adam Markes',
    coverArt:
        'https://image.freepik.com/free-psd/book-hardcover-mockup-three-views_125540-226.jpg',
    category: 'History',
    title: 'Redemtion',
    author: 'Matia Moris',
    publishmentYear: '2012',
    description:
        'Eiusmod consequat Lorem amet ipsum exercitation mollit dolore est pariatur. Sit cupidatat incididunt mollit qui enim laborum sit laboris consectetur aliquip cillum irure excepteur. Ut dolore enim minim et culpa magna consequat. Magna sit quis dolor aute est quis ipsum excepteur cillum consectetur duis.',
    resourceType: 1,
  ),
];
