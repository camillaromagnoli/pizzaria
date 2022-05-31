import './produto.model.dart';
import '../../mesa/model/mesa.model.dart';

class PedidoModel {
  List<ProdutoModel> produtos;
  MesaModel mesa;

  PedidoModel({
    required this.produtos,
    required this.mesa,
  });
}
