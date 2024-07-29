import 'package:flutter/material.dart';
import 'package:helloworld/widgets/previsaoFilterchip.dart';
import '../widgets/search_bar_with_filters.dart';
import '/pages/home.dart';

class PrevisaoPage extends StatefulWidget {
  @override
  _PrevisaoPageState createState() => _PrevisaoPageState();
}

class _PrevisaoPageState extends State<PrevisaoPage> {
  @override
  void initState() {
    super.initState();
    //fetchData();
  }

  //void fetchData() async {
  //await DataService().fetchData();
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Previsao'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()))
                  })),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  PrevisaoFilter();
          //SearchBarWithFilters(),
          SizedBox(height: 10),
        ])),
      ),
    );
  }
}
