import 'package:fitapp/Alimentos.dart';
import 'package:fitapp/Listinha.dart';
import 'package:flutter/material.dart';

class ListaAlimentos extends StatefulWidget {
  final List<Alimentos> alimentos;
  final Function(int) onRemove;
  final Function(Alimentos) onInsert;

  const ListaAlimentos({
    required this.alimentos,
    required this.onRemove,
    required this.onInsert,
    super.key,
  });

  @override
  State<ListaAlimentos> createState() => _ListaAlimentosState();
}

class _ListaAlimentosState extends State<ListaAlimentos> {
  // Controladores para nombre, calorías, proteínas, carbohidratos y grasas
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _caloriasController = TextEditingController();
  final TextEditingController _proteinasController = TextEditingController();
  final TextEditingController _carboController = TextEditingController();
  final TextEditingController _gorduraController = TextEditingController();

  // Método para abrir el modal
  void openModal(BuildContext scaffoldContext) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Column(
              children: [
                TextField(
                  decoration:
                      const InputDecoration(label: Text("Nome do Alimento")),
                  controller: _nomeController,
                ),
                TextField(
                  decoration: const InputDecoration(
                      label: Text("Calorias por 100 Gramas")),
                  controller: _caloriasController,
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  decoration: const InputDecoration(
                      label: Text("Proteinas por 100 Gramas")),
                  controller: _proteinasController,
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  decoration: const InputDecoration(
                      label: Text("Carbohidratos por 100 Gramas")),
                  controller: _carboController,
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  decoration: const InputDecoration(
                      label: Text("Gordura por 100 Gramas")),
                  controller: _gorduraController,
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  child: const Text("Salvar"),
                  onPressed: () {
                    final String nome = _nomeController.text;
                    final double? calorias =
                        double.tryParse(_caloriasController.text);
                    final double? proteinas =
                        double.tryParse(_proteinasController.text);
                    final double? carbo =
                        double.tryParse(_carboController.text);
                    final double? gordura =
                        double.tryParse(_gorduraController.text);

                    if (nome.isNotEmpty &&
                        calorias != null &&
                        proteinas != null &&
                        carbo != null &&
                        gordura != null) {
                      widget.onInsert(Alimentos(
                          nome: nome,
                          calorias: calorias,
                          proteinas: proteinas,
                          carbo: carbo,
                          gordura: gordura));

                      clearControllers();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("Alimento adicionado com sucesso!")));
                    } else {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("Preencha os campos corretamente!")));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Método para limpiar los controladores
  void clearControllers() {
    _nomeController.clear();
    _caloriasController.clear();
    _proteinasController.clear();
    _carboController.clear();
    _gorduraController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lista de Alimentos",
          style: TextStyle(
            fontSize: 16,
            color: Colors.lightGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.alimentos.length,
        itemBuilder: (context, index) {
          return Listinha(
            nome: widget.alimentos[index].nome,
            calorias: widget.alimentos[index].calorias,
            proteinas: widget.alimentos[index].proteinas,
            carbo: widget.alimentos[index].carbo,
            gordura: widget.alimentos[index].gordura,
            onRemoved: () => widget.onRemove(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModal(context);
        },
        backgroundColor: Colors.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
