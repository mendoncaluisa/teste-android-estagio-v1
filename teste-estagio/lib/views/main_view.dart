import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/viewmodels/main_viewmodel.dart';
import '/models/linhas.dart';
import '/models/corredor.dart';
import '/models/empresa.dart';

class MainView extends StatelessWidget {
  final TextEditingController termosBuscaController1 = TextEditingController();
  final TextEditingController sentidoController = TextEditingController();
  final TextEditingController termosBuscaController2 = TextEditingController();
  final TextEditingController codigoParadaController = TextEditingController();
  final TextEditingController codigoLinhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Main View')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (viewModel.isLoading)
                CircularProgressIndicator()
              else ...[
                if (viewModel.response.isNotEmpty)
                  Text('Response: ${viewModel.response}'),
                if (viewModel.linhaSentidoResponse.isNotEmpty)
                  Text(
                      'Linha Sentido Response: ${viewModel.linhaSentidoResponse}'),
                if (viewModel.paradaResponse.isNotEmpty)
                  Text('Parada Response: ${viewModel.paradaResponse}'),
                if (viewModel.paradasPorLinhaResponse.isNotEmpty)
                  Text(
                      'Paradas Por Linha Response: ${viewModel.paradasPorLinhaResponse}'),
                if (viewModel.paradasPorCorredorResponse.isNotEmpty)
                  Text(
                      'Paradas Por Corredor Response: ${viewModel.paradasPorCorredorResponse}'),
                if (viewModel.posicaoVeiculosResponse.isNotEmpty)
                  Text(
                      'Posição Veículos Response: ${viewModel.posicaoVeiculosResponse}'),
                if (viewModel.posicaoLinhaResponse.isNotEmpty)
                  Text(
                      'Posição Linha Response: ${viewModel.posicaoLinhaResponse}'),
                if (viewModel.posicaoGaragemResponse.isNotEmpty)
                  Text(
                      'Posição Garagem Response: ${viewModel.posicaoGaragemResponse}'),
                if (viewModel.previsaoResponse.isNotEmpty)
                  Text(
                      'Previsão Response: ${viewModel.previsaoResponse}'), // Add new response
                if (viewModel.previsaoPorLinhaResponse.isNotEmpty)
                  Text(
                      'Previsão Por Linha Response: ${viewModel.previsaoPorLinhaResponse}'), // Add new response

                DropdownButton<Linha>(
                  value: viewModel.selectedLinha,
                  hint: Text('Select Linha'),
                  items: viewModel.linhas.map((linha) {
                    return DropdownMenuItem<Linha>(
                      value: linha,
                      child: Text(linha.cl.toString()),
                    );
                  }).toList(),
                  onChanged: (linha) {
                    viewModel.selectLinha(linha);
                  },
                ),
                DropdownButton<Corredor>(
                  value: viewModel.selectedCorredor,
                  hint: Text('Select Corredor'),
                  items: viewModel.corredores.map((corredor) {
                    return DropdownMenuItem<Corredor>(
                      value: corredor,
                      child: Text(corredor.nc),
                    );
                  }).toList(),
                  onChanged: (corredor) {
                    viewModel.selectCorredor(corredor);
                  },
                ),
                DropdownButton<Empresa>(
                  value: viewModel.selectedEmpresa,
                  hint: Text('Select Empresa'),
                  items: viewModel.empresas.map((empresa) {
                    return DropdownMenuItem<Empresa>(
                      value: empresa,
                      child: Text(empresa.n),
                    );
                  }).toList(),
                  onChanged: (empresa) {
                    viewModel.selectEmpresa(empresa);
                  },
                ),
                TextField(
                  controller: termosBuscaController1,
                  decoration: InputDecoration(labelText: 'Termos de Busca'),
                ),
                TextField(
                  controller: sentidoController,
                  decoration: InputDecoration(labelText: 'Sentido'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: termosBuscaController2,
                  decoration: InputDecoration(labelText: 'Termos de Busca'),
                ),
                ElevatedButton(
                  onPressed: () {
                    //viewModel.fetchData();
                  },
                  child: Text('Fetch Data'),
                ),
                ElevatedButton(
                  onPressed: () {
                    viewModel.fetchLinhaSentidoData(
                      termosBuscaController1.text,
                      int.tryParse(sentidoController.text) ?? 0,
                    );
                  },
                  child: Text('Fetch Linha Sentido Data'),
                ),
                ElevatedButton(
                  onPressed: () {
                    viewModel.fetchParadaData(termosBuscaController2.text);
                  },
                  child: Text('Fetch Parada Data'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (viewModel.selectedLinha != null) {
                      viewModel.fetchParadasPorLinhaData(
                          viewModel.selectedLinha!.cl);
                    }
                  },
                  child: Text('Fetch Paradas Por Linha Data'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (viewModel.selectedCorredor != null) {
                      viewModel.fetchParadasPorCorredorData(
                          viewModel.selectedCorredor!.cc);
                    }
                  },
                  child: Text('Fetch Paradas Por Corredor Data'),
                ),
                ElevatedButton(
                  onPressed: () {
                    viewModel.fetchPosicaoVeiculos();
                  },
                  child: Text('Fetch Posição Veículos'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (viewModel.selectedLinha != null) {
                      viewModel.fetchPosicaoLinha(viewModel.selectedLinha!.cl);
                    }
                  },
                  child: Text('Fetch Posição Linha'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (viewModel.selectedLinha != null &&
                        viewModel.selectedEmpresa != null) {
                      viewModel.fetchPosicaoGaragem(
                          viewModel.selectedEmpresa!.c,
                          viewModel.selectedLinha!.cl);
                    }
                  },
                  child: Text('Fetch Posição Garagem'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (codigoParadaController.text.isNotEmpty &&
                        codigoLinhaController.text.isNotEmpty) {
                      viewModel.fetchPrevisao(
                        int.tryParse(codigoParadaController.text) ?? 0,
                        int.tryParse(codigoLinhaController.text) ?? 0,
                      );
                    }
                  },
                  child: Text('Fetch Previsão'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (viewModel.selectedLinha != null) {
                      viewModel
                          .fetchPrevisaoPorLinha(viewModel.selectedLinha!.cl);
                    }
                  },
                  child: Text('Fetch Previsão Por Linha'), // Add new button
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     if (viewModel.selectedParada != null) {
                //       viewModel
                //           .fetchPrevisaoPorParada(viewModel.selectedParada!.cl);
                //     }
                //   },
                //   child: Text('Fetch Previsão Por Parada'), // Add new button
                //),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
