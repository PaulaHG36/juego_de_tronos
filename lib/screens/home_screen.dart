import 'package:flutter/material.dart';
import 'package:juego_de_tronos/screens/detail_screen.dart';
import 'package:juego_de_tronos/services/api_service.dart';
import 'package:juego_de_tronos/models/character.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  Character? _randomCharacter;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getRandomCharacter();
  }

  //Función para obtener un personaje aleatorio
  Future<void> _getRandomCharacter() async {
    setState(() {
      _isLoading = true; //Indica que se está cargando el personaje
    });

    try {
      Character randomCharacter = await _apiService.fetcRandomCharacter();
      setState(() {
        _randomCharacter = randomCharacter; //Asignamos el personaje aleatorio
      });
    } catch (e) {
      print('Error al obtener un personaje aleatorio: $e');
    } finally {
      setState(() {
        _isLoading = false; //Se termina de cargar
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personaje aleatorio'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed:
                _getRandomCharacter, //Al presionar, obtenemos un nuevo personaje aleatorio
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _randomCharacter == null
              ? Center(child: Text('No se encontró un personaje'))
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _randomCharacter!.name.isNotEmpty
                            ? _randomCharacter!.name
                            : 'Desconocido',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(character: _randomCharacter!),
                            ),
                          );
                        },
                        child: Text('Ver detalles'),
                      ),
                    ],
                  ),
                ),
    );
  }
}
