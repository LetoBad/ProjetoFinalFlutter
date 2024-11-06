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

  void openModal(BuildContext scaffoldContext) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text("Defina os gramos ingeridos",
                    style: TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Gramos (g): "),
                    const SizedBox(width: 15),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: TextField(
                        style: const TextStyle(fontSize: 22),
                        controller: _ingeridoController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (value) {
                          setState(() {
                            _gramosing = double.tryParse(value) ?? _gramosing;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    minimumSize: const Size(200, 50),
                  ),
                  onPressed: () {
                    setState(() {
                      _gramosing = double.tryParse(_ingeridoController.text) ??
                          _gramosing;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Confirmar",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void calcularValores() {
    if (_alimentoSelecionado != null) {
      Alimentos alimento = widget.alimentos
          .firstWhere((ali) => ali.nome == _alimentoSelecionado);

      double quantcal = alimento.calorias / 100;
      double quantpro = alimento.proteinas / 100;
      double quantcar = alimento.carbo / 100;
      double quantgor = alimento.gordura / 100;

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
          Container(
            margin: const EdgeInsets.all(25),
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
                    child: Icon(Icons.opacity, color: Colors.white),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Ingerido"),
                      Text("$_gramosing g"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Calcular",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text(
                "Selecione um alimento e defina a quantidade ingerida.",
                style: TextStyle(fontSize: 10, color: Colors.grey),
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
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              const Text(
                "Valores Nutricionais Totais:",
                style: TextStyle(
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildNutritionalInfoRow("Calorias", _caltotal),
              _buildNutritionalInfoRow("Proteínas", _prototal),
              _buildNutritionalInfoRow("Carbohidratos", _carbtotal),
              _buildNutritionalInfoRow("Gorduras", _gortotal),
            ],
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 60),
              backgroundColor: Colors.lightGreen,
            ),
            onPressed: calcularValores,
            child:
                const Text("Calcular", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () => openModal(context),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.lightGreen),
            ),
            child: const Text(
              "Alterar Ingerido",
              style: TextStyle(color: Colors.lightGreen),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionalInfoRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$label:",
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(width: 5),
          Text(
            "${value.toStringAsFixed(2)} g",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
