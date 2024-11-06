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

  // Converter para Map para salvar no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'calorias': calorias,
      'proteinas': proteinas,
      'carbo': carbo,
      'gordura': gordura,
    };
  }

  // Criar Alimentos a partir de Map
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
