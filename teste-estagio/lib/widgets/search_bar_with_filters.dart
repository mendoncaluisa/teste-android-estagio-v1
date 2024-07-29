import 'package:flutter/material.dart';

class SearchBarWithFilters extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String) onEnterPressed; // Adicionando o parâmetro

  SearchBarWithFilters({
    required this.controller,
    required this.onEnterPressed,
  });

  @override
  _SearchBarWithFiltersState createState() => _SearchBarWithFiltersState();
}

class _SearchBarWithFiltersState extends State<SearchBarWithFilters> {
  String _selectedFilter = 'TODOS'; // Default filter

  final List<String> _filters = [
    'TODOS',
    'Parada por Linha',
    'Parada por Corredor'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: 'Pesquisar',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          onChanged: (value) {
            // Trigger search when text is changed (optional)
          },
          onSubmitted: (value) {
            widget.onEnterPressed(
                value); // Chama a função quando Enter é pressionado
          },
        ),
        SizedBox(height: 10),
        DropdownButton<String>(
          value: _selectedFilter,
          onChanged: (String? newValue) {
            setState(() {
              _selectedFilter = newValue!;
            });
          },
          items: _filters.map<DropdownMenuItem<String>>((String filter) {
            return DropdownMenuItem<String>(
              value: filter,
              child: Text(filter),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        Text('Filtro Selecionado: $_selectedFilter'),
      ],
    );
  }
}
