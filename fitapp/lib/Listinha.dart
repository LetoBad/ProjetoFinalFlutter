import 'package:flutter/material.dart';

class Listinha extends StatelessWidget {
  final String nome;
  final double calorias;
  final double proteinas;
  final double carbo;
  final double gordura;
  final Function() onRemoved;

  const Listinha({
    required this.nome,
    required this.calorias,
    required this.proteinas,
    required this.carbo,
    required this.gordura,
    required this.onRemoved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.fastfood,
                  color: Colors.lightGreen,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.lightGreen,
                      ),
                    ),
                    Text(
                      'Calorias: ${calorias.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      'Proteínas: ${proteinas.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      'Carbohidratos: ${carbo.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      'Gorduras: ${gordura.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onRemoved,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(
            thickness: 1,
            color: Color.fromARGB(255, 211, 211, 211),
          ),
        ],
      ),
    );
  }
}
