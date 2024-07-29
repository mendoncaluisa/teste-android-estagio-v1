import 'package:flutter/material.dart';
import '/services/request1_service.dart';
import '/services/request2_service.dart';
import '/services/request3_service.dart';
import '/services/request4_service.dart';
import '/services/request5_service.dart';
import '/services/request6_service.dart';
import '/services/request7_service.dart';
import '/services/request8_service.dart';
import '/services/request9_service.dart';
import '/services/request10_service.dart';
import '/services/request11_service.dart';
import '/services/request12_service.dart';
import '/services/request13_service.dart';

import '/models/linhas.dart';
import '/models/corredor.dart';
import '/models/empresa.dart';

class MainViewModel extends ChangeNotifier {
  final Request1Service request1Service;
  final Request2Service request2Service;
  final Request3Service request3Service;
  final Request4Service request4Service;
  final Request5Service request5Service;
  final Request6Service request6Service;
  final Request7Service request7Service;
  final Request8Service request8Service;
  final Request9Service request9Service;
  final Request10Service request10Service;
  final Request11Service request11Service;
  final Request12Service request12Service;
  final Request13Service request13Service;

  List<Linha> linhas = [];
  Linha? selectedLinha;
  List<Corredor> corredores = [];
  Corredor? selectedCorredor;
  List<Empresa> empresas = [];
  Empresa? selectedEmpresa;
  String response = '';
  String linhaSentidoResponse = '';
  String paradaResponse = '';
  String paradasPorLinhaResponse = '';
  String paradasPorCorredorResponse = '';
  String posicaoVeiculosResponse = '';
  String posicaoLinhaResponse = '';
  String posicaoGaragemResponse = '';
  String previsaoResponse = '';
  String previsaoPorLinhaResponse = '';
  bool isLoading = false;

  MainViewModel(
      this.request10Service,
      this.request1Service,
      this.request2Service,
      this.request3Service,
      this.request4Service,
      this.request5Service,
      this.request6Service,
      this.request7Service,
      this.request8Service,
      this.request9Service,
      this.request11Service,
      this.request12Service,
      this.request13Service) {
    fetchLinhas();
    fetchCorredores();
    fetchEmpresas();
  }

  Future<void> fetchLinhas() async {
    isLoading = true;
    notifyListeners();

    linhas = await request1Service.fetchData();

    isLoading = false;
    notifyListeners();
  }

  void selectLinha(Linha? linha) {
    selectedLinha = linha;
    notifyListeners();
  }

  Future<void> fetchCorredores() async {
    isLoading = true;
    notifyListeners();

    corredores = await request5Service.fetchCorredores();

    isLoading = false;
    notifyListeners();
  }

  void selectCorredor(Corredor? corredor) {
    selectedCorredor = corredor;
    notifyListeners();
  }

  void selectEmpresa(Empresa? empresa) {
    selectedEmpresa = empresa;
    notifyListeners();
  }

  Future<void> fetchData() async {
    isLoading = true;
    notifyListeners();

    response = await request1Service.fetchData().toString();

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchLinhaSentidoData(String termosBusca, int sentido) async {
    isLoading = true;
    notifyListeners();

    linhaSentidoResponse =
        await request2Service.fetchLinhaSentidoData(termosBusca, sentido);

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchParadaData(String termosBusca) async {
    isLoading = true;
    notifyListeners();

    paradaResponse = await request3Service.fetchParadaData(termosBusca);

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchParadasPorLinhaData(int codigoLinha) async {
    isLoading = true;
    notifyListeners();

    paradasPorLinhaResponse =
        await request4Service.fetchParadasPorLinhaData(codigoLinha);

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchParadasPorCorredorData(int codigoCorredor) async {
    isLoading = true;
    notifyListeners();

    paradasPorCorredorResponse =
        await request6Service.fetchParadasPorCorredor(codigoCorredor);

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPosicaoVeiculos() async {
    isLoading = true;
    notifyListeners();

    posicaoVeiculosResponse = await request7Service.fetchPosicaoVeiculos();

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPosicaoLinha(int codigoLinha) async {
    isLoading = true;
    notifyListeners();

    posicaoLinhaResponse = await request8Service.fetchPosicaoLinha(codigoLinha);

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchEmpresas() async {
    isLoading = true;
    notifyListeners();
    try {
      empresas = await request9Service.fetchEmpresas();
      // Adicionando depuração
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPosicaoGaragem(int codigoEmpresa, int codigoLinha) async {
    isLoading = true;
    notifyListeners();

    posicaoGaragemResponse =
        await request10Service.fetchPosicaoGaragem(codigoEmpresa, codigoLinha);

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPrevisaoParada(int codigoParada) async {
    isLoading = true;
    notifyListeners();

    previsaoPorLinhaResponse =
        await request11Service.fetchPrevisaoParada(codigoParada);

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPrevisaoPorLinha(int codigoLinha) async {
    isLoading = true;
    notifyListeners();

    previsaoPorLinhaResponse =
        await request12Service.fetchPrevisaoPorLinha(codigoLinha);

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPrevisao(int codigoParada, int codigoLinha) async {
    isLoading = true;
    notifyListeners();

    previsaoResponse =
        await request13Service.fetchPrevisao(codigoParada, codigoLinha);

    isLoading = false;
    notifyListeners();
  }
}
