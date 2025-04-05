import 'package:flutter/material.dart';
import 'joke.dart';


class JokeDetailView extends StatelessWidget {
  final Joke joke;

  const JokeDetailView({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del Chiste')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(joke.iconUrl, height: 100),
            const SizedBox(height: 20),
            Text(
              joke.value,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
