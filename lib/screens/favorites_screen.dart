import 'package:flutter/material.dart';
import 'package:juego_de_tronos/screens/detail_screen.dart';
import 'package:juego_de_tronos/providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import 'package:juego_de_tronos/screens/detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(title: Text('Favoritos')),
      body: favorites.isEmpty
          ? Center(
              child: Text('No tienes personajes favoritos aún',
                  style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final character = favorites[index];
                return InkWell(
                  onTap: () {
                    // Al hacer clic sobre un personaje, navegar a la pantalla de detalles
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(character: character),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(character.name),
                  ),
                );
              },
            ),
    );
  }
}
