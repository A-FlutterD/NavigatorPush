import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RandomWord(),
    );
  }
}
class RandomWord extends StatefulWidget {
  const RandomWord({super.key});

  @override
  State<RandomWord> createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWord> {
  final List<WordPair> suggestions = <WordPair>[];
  final TextStyle biggerFont = const TextStyle(fontSize: 18);
  final List<WordPair> favorites = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Name lists") ,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen(favorites: favorites)));
            },
          )
        ],
      ),
      body: buildSuggestions(),
    );
  }
  Widget buildSuggestions(){
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd){
            return const Divider(
              thickness: 2,
              color: Colors.cyan,
            );
          }
          final int index = i ~/ 2;
          if (index >= suggestions.length){
            suggestions.addAll(generateWordPairs().take(10));
          }
          return buildRow(suggestions[index]);
        }
    );
  }
  Widget buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: biggerFont,
      ),
      trailing: IconButton(
        icon: favorites.contains(pair) ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
        color: favorites.contains(pair) ? Colors.redAccent : Colors.black,
        onPressed: () {
          toggleFavorite(pair);
        },
      ),
    );
  }

  void toggleFavorite(WordPair word) {
    setState(() {
      if (favorites.contains(word)) {
        favorites.remove(word);
      } else {
        favorites.add(word);
      }
    });
  }
}

class FavoritesScreen extends StatelessWidget {
  final List<WordPair> favorites;
  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favorites[index].toString()),
          );
        },
      ),
    );
  }
}


