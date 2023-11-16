import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Fruit {
  final String name;
  bool isFavorite;

  Fruit({required this.name, this.isFavorite = false});
}
class FruitsPage extends StatefulWidget {
  @override
  _FruitsPageState createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage> {
  List<Fruit> fruits = [
    Fruit(name: 'Apple'),
    Fruit(name: 'Banana'),
    Fruit(name: 'Orange'),
  ];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fruits.forEach((fruit) {
        fruit.isFavorite = prefs.getBool(fruit.name) ?? false;
      });
    });
  }

  Future<void> toggleFavorite(Fruit fruit) async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !fruit.isFavorite;
    setState(() {
      fruit.isFavorite = newValue;
    });
    await prefs.setBool(fruit.name, newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Fruits'),
      ),
      body: ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          final fruit = fruits[index];
          return ListTile(
            title: Text(fruit.name),
            trailing: IconButton(
              icon: Icon(
                fruit.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: fruit.isFavorite ? Colors.red : null,
              ),
              onPressed: () => toggleFavorite(fruit),
            ),
          );
        },
      ),
    );
  }
}