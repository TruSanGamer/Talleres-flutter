import 'dart:convert';
import 'package:http/http.dart' as http;
import 'joke.dart';

class JokeService {
  static const String _baseUrl = 'https://api.chucknorris.io/jokes/random';

  static Future<List<Joke>> fetchJokes(int count) async {
    List<Joke> jokes = [];
    try {
      for (int i = 0; i < count; i++) {
        final response = await http.get(Uri.parse(_baseUrl));
        if (response.statusCode == 200) {
          jokes.add(Joke.fromJson(json.decode(response.body)));
        } else {
          throw Exception('Error al cargar chistes');
        }
      }
    } catch (e) {
      throw Exception('Fallo la conexión: $e');
    }
    return jokes;
  }
}
