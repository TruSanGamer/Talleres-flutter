class Joke {
  final String id;
  final String value;
  final String iconUrl;

  Joke({required this.id, required this.value, required this.iconUrl});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'],
      value: json['value'],
      iconUrl: json['icon_url'],
    );
  }
}
