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
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(0),
          ),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const Text("Defina os gramos ingeridos"),
                      const SizedBox(height: 40),
                      // gramos ingeridos
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Gramos (Gr\$)"),
                          const SizedBox(width: 35),
                          SizedBox(
                            width: 100,
                            height: 80,
                            child: TextField(
                              style: const TextStyle(fontSize: 35),
                              controller: _ingeridoController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 150),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            minimumSize: const Size(200, 50),
                          ),
                          onPressed: () {
                            setState(() {
                              _gramosing =
                                  double.parse(_ingeridoController.text);
                            });
                            Navigator.pop(context); // Fechar modal
                          },
                          child: const Text("Confirmar",
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  //METODO PARA CALCULAR
  void calcularCusto() {
    if (_alimentoSelecionado != null) {
      Alimentos alimentos = widget.alimentos
          .firstWhere((ali) => ali.nome == _alimentoSelecionado);

      //Calcular o valor nutricional por gramo
      double quantcal = alimentos.calorias / 100;
      double quantpro = alimentos.proteinas / 100;
      double quantcar = alimentos.carbo / 100;
      double quantgor = alimentos.gordura / 100;

      //Calcula o total dos valores por as gramas ingeridas
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
                      Text(_gramosing.toString()),
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
                "Selecione um Aliemto e defina a quantidade ingerida.",
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
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Valores Total:",
                        style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Gramos ingeridos:",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "BRL${_gramosing.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
          Container(
            margin: const EdgeInsets.only(top: 50, left: 0),
            width: 140,
            height: 35,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                side: const BorderSide(color: Colors.lightGreen, width: 1.0),
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {
                openModal(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.lightGreen,
                    size: 12,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Alterar Ingerido",
                    style: TextStyle(fontSize: 12, color: Colors.lightGreen),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
