import 'package:flutter/material.dart';
import 'joke.dart';               
import 'joke_service.dart';      
import 'joke_detail_view.dart';  

class JokeListView extends StatefulWidget {
  const JokeListView({super.key});

  @override
  State<JokeListView> createState() => _JokeListViewState();
}

class _JokeListViewState extends State<JokeListView> {
  late Future<List<Joke>> _futureJokes;

  @override
  void initState() {
    super.initState();
    _futureJokes = JokeService.fetchJokes(10); // Carga 10 chistes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chistes de Chuck Norris')),
      body: FutureBuilder<List<Joke>>(
        future: _futureJokes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('⚠️ Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron chistes'));
          }

          final jokes = snapshot.data!;
          return ListView.builder(
            itemCount: jokes.length,
            itemBuilder: (_, index) {
              final joke = jokes[index];
              return ListTile(
                leading: Image.network(joke.iconUrl, height: 40),
                title: Text(joke.value, maxLines: 2, overflow: TextOverflow.ellipsis),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => JokeDetailView(joke: joke),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
