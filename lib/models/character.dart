class Character {
  final String name;
  final String gender;
  final String culture;
  final String born;
  final String died;
  final String url;

  Character({
    required this.name,
    required this.gender,
    required this.culture,
    required this.born,
    required this.died,
    required this.url,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: _getValidString(json['name']),
      gender: _getValidString(json['gender']),
      culture: _getValidString(json['culture']),
      born: _getValidString(json['born']),
      died: _getValidString(json['died']),
      url: json['url'] ?? 'Desconocido',
    );
  }

  static String _getValidString(String? value) {
    if (value == null || value.isEmpty) {
      return 'Desconocido';
    }
    return value;
  }
}
