import 'package:flutter/material.dart';
import '../widgets/search_bar_with_filters.dart';
import '/pages/home.dart';

class PosicaoPage extends StatefulWidget {
  @override
  _PosicaoPageState createState() => _PosicaoPageState();
}

class _PosicaoPageState extends State<PosicaoPage> {
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
          title: Text('Posição'),
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
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //SearchBarWithFilters(),
          SizedBox(height: 10),
        ])),
      ),
    );
  }
}
