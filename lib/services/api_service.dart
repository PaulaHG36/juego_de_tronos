import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:juego_de_tronos/models/character.dart';

class ApiService {
  final String baseUrl = 'https://www.anapioficeandfire.com/api/characters';

  //Obtener una lista de personajes y devolver uno aleatorio
  Future<Character> fetcRandomCharacter() async {
    //Solicitud para obtener los primeros 50 personajes
    final response = await http.get(Uri.parse(
        '$baseUrl?page=1&pageSize=50')); //Obtener los primeros 50 personajes

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      //Si no hay personajes, se lanza una excepción
      if (data.isEmpty) {
        throw Exception('No se han encontrado personajes');
      }

      //Elegir personaje aleatorio de la lista
      Random random = Random();
      int randomIndex = random.nextInt(data.length);
      return Character.fromJson(data[randomIndex]);
    } else {
      throw Exception('Fallo al cargar un personaje aleatorio');
    }
  }

  //Obtener personajes por página
  Future<List<Character>> fetchCharacters(int page) async {
    final response =
        await http.get(Uri.parse('$baseUrl?page=$page&pageSize=10'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Fallo al cargar los personajes');
    }
  }
}
