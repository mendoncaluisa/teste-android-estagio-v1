import 'dart:convert';
import 'package:flutter/material.dart';
import '/pages/home.dart';
import '../services/request1_service.dart';
import '../services/request2_service.dart'; // Import Request2Service
import '../models/linhas.dart'; // Certifique-se de importar o modelo Linha
//import '../widgets/search_bar_with_filters.dart';

class SearchBarWithFilters extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onEnterPressed;

  SearchBarWithFilters({
    required this.controller,
    required this.onEnterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (value) {
        onEnterPressed(value);
      },
      decoration: InputDecoration(
        labelText: 'Search',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class LinhasPage extends StatefulWidget {
  final Request1Service request1Service;
  final Request2Service request2Service; // Add Request2Service

  LinhasPage({
    required this.request1Service,
    required this.request2Service, // Initialize Request2Service
  });

  @override
  _LinhasPageState createState() => _LinhasPageState();
}

class _LinhasPageState extends State<LinhasPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Linha> _responseData = [];
  bool _isLoading = false;
  String _selectedFilter = 'Todos'; // Exemplo de filtro
  int _selectedSentido = 1; // Default sentido value

  @override
  void initState() {
    super.initState();
  }

  void _onEnterPressed(String value) async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_selectedFilter == 'Sentido Linha') {
        // Use Request2Service with sentido parameter
        String response = await widget.request2Service
            .fetchLinhaSentidoData(value, _selectedSentido);
        // Parse the response into the desired format
        List<Map<String, dynamic>> parsedResponse = parseResponse(response);
        setState(() {
          _responseData = Linha.fromJsonList(parsedResponse);
        });
      } else {
        // Use Request1Service
        List<Map<String, dynamic>> response =
            await widget.request1Service.fetchData(value);
        setState(() {
          _responseData = Linha.fromJsonList(response);
        });
      }
    } catch (e) {
      print('Erro: $e');
      setState(() {
        _responseData = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> parseResponse(String response) {
    // Implement this method to parse the response string into a list of maps
    List<dynamic> jsonResponse = json.decode(response);
    return jsonResponse.map((item) => item as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Linhas'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()))
                  })),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchBarWithFilters(
                controller: _searchController,
                onEnterPressed: _onEnterPressed,
              ),
              DropdownButton<String>(
                value: _selectedFilter,
                items: <String>['Todos', 'Sentido Linha'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedFilter = newValue!;
                  });
                },
              ),
              if (_selectedFilter == 'Sentido Linha')
                DropdownButton<int>(
                  value: _selectedSentido,
                  items: <int>[1, 2].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value == 1
                          ? 'Terminal Principal para Terminal Secundário'
                          : 'Terminal Secundário para Terminal Principal'),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSentido = newValue!;
                    });
                  },
                ),
              SizedBox(height: 10),
              _isLoading
                  ? CircularProgressIndicator()
                  : _responseData.isEmpty
                      ? Text('Nenhum dado disponível')
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _responseData.map((linha) {
                            return ListTile(
                              title: Text(
                                  '${linha.cl} - ${linha.tp} -> ${linha.ts}'),
                            );
                          }).toList(),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Request1Service request1Service =
      Request1Service('https://aiko-olhovivo-proxy.aikodigital.io');
  final Request2Service request2Service =
      Request2Service('https://aiko-olhovivo-proxy.aikodigital.io');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LinhasPage(
        request1Service: request1Service,
        request2Service: request2Service, // Initialize Request2Service
      ),
    );
  }
}
