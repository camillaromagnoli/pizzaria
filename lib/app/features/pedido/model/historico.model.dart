import './pedido.model.dart';

class HistoricoModel {
  double total;
  PedidoModel pedido;
  String horario;

  HistoricoModel(
      {required this.total, required this.pedido, required this.horario});
}
