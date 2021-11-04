class Subscribtion {
  final String id, name;
  final DateTime dateSubscribed;
  final int reaminingSecond;

  Subscribtion({
    required this.id,
    required this.name,
    required this.dateSubscribed,
    required this.reaminingSecond,
  });

  factory Subscribtion.fromMap(Map<String, dynamic> json) => Subscribtion(
        id: json['id'],
        name: json['name'],
        dateSubscribed: json['dateSubscribed'],
        reaminingSecond: json['reaminingSecond'],
      );
}
