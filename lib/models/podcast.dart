class Podcast {
  final String id, title, podcastImage, description, creators, category;

  Podcast({
    required this.id,
    required this.title,
    required this.podcastImage,
    required this.description,
    required this.creators,
    required this.category,
  });
  factory Podcast.fromMap(Map<String, dynamic> json) => Podcast(
        id: json['id'],
        title: json['title'],
        podcastImage: json['podcastImage'],
        description: json['description'],
        creators: json[' creators'],
        category: json['category'],
      );
}

final List<Podcast> pods = [
  Podcast(
    id: 'id',
    title: 'win today',
    podcastImage:
        'https://image.freepik.com/free-psd/arrangement-mock-up-book-cover_23-2149059351.jpg',
    description: 'learn to live today',
    creators: 'me, I created it',
    category: 'motivation | self empowerment',
  ),
  Podcast(
    id: 'id',
    title: 'win today',
    podcastImage:
        'https://image.freepik.com/free-psd/book-cover-mockup_125540-572.jpg',
    description: 'learn to live today',
    creators: 'me, I created it',
    category: 'motivation | self empowerment',
  ),
  Podcast(
    id: 'id',
    title: 'win today',
    podcastImage:
        'https://image.freepik.com/free-psd/book-hardcover-mockup-three-views_125540-226.jpg',
    description: 'learn to live today',
    creators: 'me, I created it',
    category: 'motivation | self empowerment',
  ),
  Podcast(
    id: 'id',
    title: 'win today',
    podcastImage:
        'https://image.freepik.com/free-psd/book-s-cover-pages-mock-up_1390-100.jpg',
    description: 'learn to live today',
    creators: 'me, I created it',
    category: 'motivation | self empowerment',
  ),
  Podcast(
    id: 'id',
    title: 'win today',
    podcastImage:
        'https://image.freepik.com/free-psd/top-view-book-coffee-cup-arrangement_23-2149040132.jpg',
    description: 'learn to live today',
    creators: 'me, I created it',
    category: 'motivation | self empowerment',
  ),
  Podcast(
    id: 'id',
    title: 'win today',
    podcastImage:
        'https://image.freepik.com/free-psd/side-view-minimalist-book-cover-mockup_352777-24.jpg',
    description: 'learn to live today',
    creators: 'me, I created it',
    category: 'motivation | self empowerment',
  ),
];
