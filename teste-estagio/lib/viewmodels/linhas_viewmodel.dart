import 'package:flutter/material.dart';
import '/services/request1_service.dart';
import '/models/linhas.dart';

class LinhasViewModel extends ChangeNotifier {
  final Request1Service request1Service;

  List<Linha> linhas = [];
  bool isLoading = false;

  LinhasViewModel(this.request1Service);

  Future<void> fetchData(int termosBusca) async {
    isLoading = true;
    notifyListeners();

    linhas = await request1Service.fetchData(termosBusca);

    isLoading = false;
    notifyListeners();
  }
}
