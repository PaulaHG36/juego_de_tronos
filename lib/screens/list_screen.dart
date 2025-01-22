import 'package:flutter/material.dart';
import 'package:juego_de_tronos/services/api_service.dart';
import 'package:juego_de_tronos/models/character.dart';
import 'detail_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final ApiService _apiService = ApiService();
  List<Character> _characters = [];
  int _page = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    try {
      List<Character> newCharacters = await _apiService.fetchCharacters(_page);
      setState(() {
        _characters = newCharacters;
      });
    } catch (e) {
      print('Error al cargar personajes: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _nextPage() {
    setState(() {
      _page++;
    });
    _loadCharacters();
  }

  void _previousPage() {
    if (_page > 1) {
      setState(() {
        _page--;
      });
      _loadCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Personajes')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _characters.length + 1,
              itemBuilder: (context, index) {
                if (index == _characters.length) {
                  return _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Container();
                }

                final character = _characters[index];
                return ListTile(
                  title: Text(character.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(character: character),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: _page > 1 ? _previousPage : null,
                ),
                Text(
                  'Página $_page',
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: _isLoading ? null : _nextPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
