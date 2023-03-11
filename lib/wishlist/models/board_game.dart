class BoardGame {
  const BoardGame({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory BoardGame.fromJson(Map<String, dynamic> json) => BoardGame(
        id: json['id'],
        name: json['name'],
        imageUrl: json['image_url'],
      );

  final String id;
  final String name;
  final String imageUrl;
}
