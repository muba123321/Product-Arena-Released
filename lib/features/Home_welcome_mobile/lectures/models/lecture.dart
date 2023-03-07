class Lecture {
  final String name;
  final String contentLink;
  final String description;
  final String imageSrc;
  final double durationInSeconds;
  Lecture({
    required this.name,
    required this.contentLink,
    required this.description,
    required this.imageSrc,
    required this.durationInSeconds,
  });

  factory Lecture.fromJson(Map<String, dynamic> lectures) {
    return Lecture(
      name: lectures['name'],
      contentLink: lectures['currenLink'],
      description: lectures['description'],
      imageSrc: lectures['imageSrc'],
      durationInSeconds: lectures['durationInSeconds'],
    );
  }
}
