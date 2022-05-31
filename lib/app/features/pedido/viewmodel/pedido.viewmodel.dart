import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:collection/collection.dart';

import '../../mesa/model/mesa.model.dart';
import '../model/historico.model.dart';
import '../model/pedido.model.dart';
import '../model/produto.model.dart';

part 'pedido.viewmodel.g.dart';

class PedidoViewModel extends _PedidoViewModelBase
    with _$PedidoViewModel, Disposable {
  @override
  void dispose() {}
}

abstract class _PedidoViewModelBase with Store {
  @observable
  ObservableList<HistoricoModel> historico = ObservableList.of([]);

  List<PedidoModel> pedidosAtivos = [];

  @observable
  PedidoModel? pedido;

  @action
  adicionarProduto(
      {required String nome, required int quantidade, required double preco}) {
    PedidoModel? pedidoAtual = pedido;
    pedidoAtual?.produtos
        .add(ProdutoModel(nome: nome, quantidade: quantidade, preco: preco));
    pedido = pedidoAtual;
    atualizarListaPedidos();
  }

  @action
  removerProduto(int index) {
    PedidoModel? pedidoAtual = pedido;
    pedidoAtual?.produtos.removeAt(index);
    pedido = pedidoAtual;
    atualizarListaPedidos();
  }

  void atualizarListaPedidos() {
    if (pedido != null) {
      limparPedidoAtual();
      pedidosAtivos.add(pedido!);
    }
  }

  void limparPedidoAtual() {
    pedidosAtivos
        .removeWhere((element) => element.mesa.numero == pedido?.mesa.numero);
  }

  double calcularTotalPedido() {
    double total = 0.0;
    for (var produto in pedido!.produtos) {
      total += (produto.preco * produto.quantidade);
    }
    return total;
  }

  @action
  finalizarPedido() {
    if (pedido != null) {
      pedido!.mesa.ocupado = false;
      historico.add(HistoricoModel(
          total: calcularTotalPedido(),
          pedido: pedido!,
          horario: DateFormat.Hms().format(DateTime.now())));
      limparPedidoAtual();
      inicializarPedido(pedido!.mesa);
    }
  }

  @action
  carregarListaDeProdutos(MesaModel mesa) {
    final PedidoModel? pedidoAtual = pedidosAtivos
        .firstWhereOrNull((pedido) => pedido.mesa.numero == mesa.numero);
    if (pedidoAtual != null) {
      pedido = pedidoAtual;
    } else {
      inicializarPedido(mesa);
    }
  }

  void inicializarPedido(MesaModel mesa) {
    pedido = PedidoModel(produtos: [], mesa: mesa);
  }

  @action
  double calcularTotalHistorico() {
    double total = 0.00;
    if (historico.isNotEmpty) {
      for (var pedido in historico) {
        total += pedido.total;
      }
    }
    return total;
  }
}
