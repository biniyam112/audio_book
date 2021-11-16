class Subscribtion {
  final String id, name;
  final String? description;
  final Duration duration;
  final int fee;

  Subscribtion({
    required this.id,
    required this.fee,
    required this.name,
    required this.duration,
    required this.description,
  });

  factory Subscribtion.fromMap(Map<String, dynamic> json) => Subscribtion(
        id: json['id'],
        name: json['name'],
        fee: json['fee'],
        duration: Duration(days: json['duration']),
        description: json['description'],
      );
}

class MySubscribtion {
  final String id, name, description;
  final Duration duration;
  final int fee;
  final DateTime purchasedAt;
  final int remainingTimeInSeconds;

  MySubscribtion(
    this.id,
    this.name,
    this.description,
    this.duration,
    this.fee,
    this.purchasedAt,
    this.remainingTimeInSeconds,
  );
}
