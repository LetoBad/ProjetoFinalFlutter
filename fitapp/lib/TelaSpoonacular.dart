import 'package:flutter/material.dart';

class TelaSpoonacular extends StatefulWidget {
  @override
  _TelaSpoonacularState createState() => _TelaSpoonacularState();
}

class _TelaSpoonacularState extends State<TelaSpoonacular> {
  String _resultado = 'Sem receitas para exibir';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela de Receitas"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Ação simples ao clicar no botão
                    _resultado =
                        'Aqui poderiam ser exibidas receitas estáticas!';
                  });
                },
                child: const Text("Mostrar Receitas")),
            const SizedBox(height: 20),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}
