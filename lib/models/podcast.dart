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
  )
];
