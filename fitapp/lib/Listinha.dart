import 'package:flutter/material.dart';

class listinha extends StatelessWidget {
  final String nome;
  final double calorias;
  final double proteinas;
  final double carbo;
  final double gordura;
  final Function() onRemoved;

  const listinha(
      {required this.nome,
      required this.calorias,
      required this.proteinas,
      required this.carbo,
      required this.gordura,
      required this.onRemoved,
      super.key});

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
                  Icons.directions_car_outlined,
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
                          color: Colors.lightGreen),
                    ),
                    Text(
                      'Quilômetros rodados por Litro: $km',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  onRemoved();
                },
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
          )
        ],
      ),
    );
  }
}