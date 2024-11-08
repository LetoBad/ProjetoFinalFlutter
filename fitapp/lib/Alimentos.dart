class Alimentos {
  final String nome;
  final double calorias;
  final double proteinas;
  final double carbo;
  final double gordura;

  Alimentos({
    required this.nome,
    required this.calorias,
    required this.proteinas,
    required this.carbo,
    required this.gordura,
  });

  // Convertir Alimentos a Map para inserción en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'calorias': calorias,
      'proteinas': proteinas,
      'carbo': carbo,
      'gordura': gordura,
    };
  }

  // Convertir Map a Alimentos al recuperar de la base de datos
  factory Alimentos.fromMap(Map<String, dynamic> map) {
    return Alimentos(
      nome: map['nome'],
      calorias: map['calorias'],
      proteinas: map['proteinas'],
      carbo: map['carbo'],
      gordura: map['gordura'],
    );
  }

  @override
  String toString() {
    return 'Alimentos(nome: $nome, calorias: $calorias, proteinas: $proteinas, carbo: $carbo, gordura: $gordura)';
  }
}
