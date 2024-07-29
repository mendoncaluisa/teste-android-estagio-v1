import 'package:flutter/material.dart';
import 'package:helloworld/pages/home.dart';
import 'dart:convert'; // Importar para usar json.decode
import '../models/corredor.dart';
import '../services/request1_service.dart';
import '../services/request3_service.dart';
import '../services/request4_service.dart';
import '../services/request5_service.dart';
import '../services/request6_service.dart';
import '../models/parada.dart';
import '../widgets/search_bar_with_filters.dart';

class ParadasPage extends StatefulWidget {
  final Request1Service request1Service;
  final Request3Service request3Service;
  final Request4Service request4Service;
  final Request5Service request5Service;
  final Request6Service request6Service;

  ParadasPage({
    required this.request1Service,
    required this.request3Service,
    required this.request4Service,
    required this.request5Service,
    required this.request6Service,
  });

  @override
  _ParadasPageState createState() => _ParadasPageState();
}

class _ParadasPageState extends State<ParadasPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _dropdownOptions = [];
  List<Parada> _responseData = [];
  List<Corredor> _corredores = [];
  bool _isLoading = false;
  String _selectedFilter = 'TODOS'; // Default filter
  int? _selectedCodigoLinha;
  int? _selectedCodigoCorredor; // Variable to hold the selected corredor value

  @override
  void initState() {
    super.initState();
    _fetchCorredores();
  }

  void _fetchCorredores() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Corredor> corredores =
          await widget.request5Service.fetchCorredores();
      setState(() {
        _corredores = corredores;
      });
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onEnterPressed(String value) async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_selectedFilter == 'Parada por Linha' &&
          _selectedCodigoLinha != null) {
        List<Map<String, dynamic>> dropdownResponse =
            await widget.request1Service.fetchData(value);
        String response = await widget.request4Service
            .fetchParadasPorLinhaData(_selectedCodigoLinha!);
        List<dynamic> parsedResponse = json.decode(response);
        setState(() {
          _responseData = parsedResponse
              .map((data) => Parada.fromJson(data as Map<String, dynamic>))
              .toList();
          _dropdownOptions = dropdownResponse;
        });
      } else if (_selectedFilter == 'TODOS') {
        String response = await widget.request3Service.fetchParadaData(value);
        List<dynamic> parsedResponse = json.decode(response);
        setState(() {
          _responseData = parsedResponse
              .map((data) => Parada.fromJson(data as Map<String, dynamic>))
              .toList();
        });
      } else if (_selectedFilter == 'Parada por Corredor' &&
          _selectedCodigoCorredor != null) {
        String response = await widget.request6Service
            .fetchParadasPorCorredor(_selectedCodigoCorredor!);
        List<dynamic> parsedResponse = json.decode(response);
        setState(() {
          _responseData = parsedResponse
              .map((data) => Parada.fromJson(data as Map<String, dynamic>))
              .toList();
        });
      }
    } catch (e) {
      setState(() {
        _responseData = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Paradas'),
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
              if (_selectedFilter == 'Parada por Linha')
                DropdownButton<int>(
                  value: _selectedCodigoLinha,
                  items: _dropdownOptions.map((option) {
                    return DropdownMenuItem<int>(
                      value: option['cl'] as int,
                      child: Text('${option['tp']} - ${option['ts']}'),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCodigoLinha = newValue;
                    });
                  },
                ),
              if (_selectedFilter == 'Parada por Corredor')
                DropdownButton<int>(
                  value: _selectedCodigoCorredor,
                  items: _corredores.map((corredor) {
                    return DropdownMenuItem<int>(
                      value: corredor.cc,
                      child: Text(corredor.nc),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCodigoCorredor = newValue;
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
                          children: _responseData.map((parada) {
                            return ListTile(
                              title: Text(
                                  '${parada.cp} - ${parada.np} - ${parada.ed}'),
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
  runApp(MyParada());
}

class MyParada extends StatelessWidget {
  final Request1Service request1Service =
      Request1Service('https://aiko-olhovivo-proxy.aikodigital.io');
  final Request4Service request4Service =
      Request4Service('https://aiko-olhovivo-proxy.aikodigital.io');
  final Request3Service request3Service =
      Request3Service('https://aiko-olhovivo-proxy.aikodigital.io');
  final Request5Service request5Service =
      Request5Service('https://aiko-olhovivo-proxy.aikodigital.io');
  final Request6Service request6Service =
      Request6Service('https://aiko-olhovivo-proxy.aikodigital.io');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ParadasPage(
        request1Service: request1Service,
        request4Service: request4Service,
        request3Service: request3Service,
        request5Service: request5Service,
        request6Service: request6Service,
      ),
    );
  }
}
