class Alimentos {
  final int? id;
  final String nome;
  final double calorias;
  final double proteinas;
  final double carbo;
  final double gordura;

  Alimentos({this.id , required this.nome, required this.calorias, required this.proteinas, required this.carbo, required this.gordura});

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'nome': nome,
      'calorias': calorias,
      'proteinas': proteinas,
      'carbo': carbo,
      'gordura': gordura,
    
    };
  }

  static Alimentos fromMap(Map<String, dynamic> map) {
    return Alimentos(
      id: map['id'],
      nome: map['nome'],
      calorias: map['calorias'],
      proteinas: map['protienas'],
      carbo: map['carbo'],
      gordura: map['gordura'],
    );
  }
}