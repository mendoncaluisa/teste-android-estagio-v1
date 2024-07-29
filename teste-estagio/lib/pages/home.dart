import 'package:flutter/material.dart';
import 'linhas.dart';
import 'paradas.dart';
import 'posicao.dart';
import 'previsao.dart';
import 'empresas.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildButton(context, 'Linhas', MyApp()),
            SizedBox(height: 10),
            _buildButton(context, 'Paradas', MyParada()),
            SizedBox(height: 10),
            _buildButton(context, 'Posicao', PosicaoPage()),
            SizedBox(height: 10),
            _buildButton(context, 'Previsao', PrevisaoPage()),
            SizedBox(height: 10),
            _buildButton(context, 'Empresas', EmpresasPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Widget page) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(text),
          ],
        ),
      ),
    );
  }
}
