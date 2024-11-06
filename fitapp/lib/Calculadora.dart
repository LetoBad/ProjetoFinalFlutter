import 'package:fitapp/Alimentos.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  final List<Alimentos> alimentos;

  const Calculadora({
    super.key,
    required this.alimentos,
  });

  @override
  State<Calculadora> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<Calculadora> {
  String? _alimentoSelecionado;
  double _gramosing = 100;
  double _caltotal = 0;
  double _prototal = 0;
  double _carbtotal = 0;
  double _gortotal = 0;

  final TextEditingController _ingeridoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ingeridoController.text = _gramosing.toString();
  }

  // METODO PARA CALCULAR
  void calcularCusto() {
    if (_alimentoSelecionado != null) {
      Alimentos alimentos = widget.alimentos
          .firstWhere((ali) => ali.nome == _alimentoSelecionado);

      // Calcular o valor nutricional por gramo
      double quantcal = alimentos.calorias / 100;
      double quantpro = alimentos.proteinas / 100;
      double quantcar = alimentos.carbo / 100;
      double quantgor = alimentos.gordura / 100;

      // Calcula o total dos valores por as gramas ingeridas
      setState(() {
        _caltotal = quantcal * _gramosing;
        _prototal = quantpro * _gramosing;
        _carbtotal = quantcar * _gramosing;
        _gortotal = quantgor * _gramosing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Container com as variáveis
          Container(
            margin: const EdgeInsets.fromLTRB(25, 25, 25, 25),
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.lightGreen,
                    child: Icon(
                      Icons.opacity,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Ingerido"),
                      // valor atualizado do ingerido
                      Text(_gramosing.toString() + " g"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Container de 'Calcular' com dropdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Calcular",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text(
                "Selecione um Alimento e defina a quantidade ingerida.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 300,
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Selecione um alimento"),
                  value: _alimentoSelecionado,
                  items: widget.alimentos.map((Alimentos alimentos) {
                    return DropdownMenuItem<String>(
                      value: alimentos.nome,
                      child: Text(alimentos.nome),
                    );
                  }).toList(),
                  onChanged: (String? novoAlimento) {
                    setState(() {
                      _alimentoSelecionado = novoAlimento;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Campo para definir a quantidade ingerida
              _alimentoSelecionado != null
                  ? Column(
                      children: [
                        const Text("Defina a quantidade ingerida (gramas):"),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            controller: _ingeridoController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                _gramosing = double.tryParse(value) ?? 100;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: "Gramas",
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
          const SizedBox(height: 20),
          // Exibição dos valores totais de calorias, proteínas, carboidratos e gorduras
          _alimentoSelecionado != null
              ? Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Valores Totais:",
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Calorias: ",
                            style: TextStyle(color: Colors.grey)),
                        Text(
                          "${_caltotal.toStringAsFixed(2)} kcal",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Proteínas: ",
                            style: TextStyle(color: Colors.grey)),
                        Text(
                          "${_prototal.toStringAsFixed(2)} g",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Carboidratos: ",
                            style: TextStyle(color: Colors.grey)),
                        Text(
                          "${_carbtotal.toStringAsFixed(2)} g",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Gorduras: ",
                            style: TextStyle(color: Colors.grey)),
                        Text(
                          "${_gortotal.toStringAsFixed(2)} g",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Container(),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 60),
              backgroundColor: Colors.lightGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () {
              calcularCusto();
            },
            child: const Text(
              "Calcular",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
