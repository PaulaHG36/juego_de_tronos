import 'package:flutter/material.dart';
import 'package:juego_de_tronos/models/character.dart';
import 'package:juego_de_tronos/providers/favorites_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final Character character;

  DetailScreen({required this.character});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                character.name.isNotEmpty ? character.name : 'Desconocido',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text('Género: ${character.gender}',
                  style: TextStyle(fontSize: 18)),
              Text('Cultura: ${character.culture}',
                  style: TextStyle(fontSize: 18)),
              Text('Nacimiento: ${character.born}',
                  style: TextStyle(fontSize: 18)),
              Text('Muerte: ${character.died}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (favoritesProvider.favorites.contains(character)) {
                    favoritesProvider.removeFavorite(character);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('${character.name} eliminado de favoritos')));
                  } else {
                    favoritesProvider.addFavorite(character);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('${character.name} agregado a favoritos')));
                  }
                },
                child: Text(
                  favoritesProvider.favorites.contains(character)
                      ? 'Eliminar de Favoritos'
                      : 'Agregar a Favoritos',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
