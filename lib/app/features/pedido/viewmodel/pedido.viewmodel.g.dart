// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido.viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PedidoViewModel on _PedidoViewModelBase, Store {
  late final _$historicoAtom =
      Atom(name: '_PedidoViewModelBase.historico', context: context);

  @override
  ObservableList<HistoricoModel> get historico {
    _$historicoAtom.reportRead();
    return super.historico;
  }

  @override
  set historico(ObservableList<HistoricoModel> value) {
    _$historicoAtom.reportWrite(value, super.historico, () {
      super.historico = value;
    });
  }

  late final _$pedidoAtom =
      Atom(name: '_PedidoViewModelBase.pedido', context: context);

  @override
  PedidoModel? get pedido {
    _$pedidoAtom.reportRead();
    return super.pedido;
  }

  @override
  set pedido(PedidoModel? value) {
    _$pedidoAtom.reportWrite(value, super.pedido, () {
      super.pedido = value;
    });
  }

  late final _$_PedidoViewModelBaseActionController =
      ActionController(name: '_PedidoViewModelBase', context: context);

  @override
  dynamic adicionarProduto(
      {required String nome, required int quantidade, required double preco}) {
    final _$actionInfo = _$_PedidoViewModelBaseActionController.startAction(
        name: '_PedidoViewModelBase.adicionarProduto');
    try {
      return super
          .adicionarProduto(nome: nome, quantidade: quantidade, preco: preco);
    } finally {
      _$_PedidoViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removerProduto(int index) {
    final _$actionInfo = _$_PedidoViewModelBaseActionController.startAction(
        name: '_PedidoViewModelBase.removerProduto');
    try {
      return super.removerProduto(index);
    } finally {
      _$_PedidoViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic finalizarPedido() {
    final _$actionInfo = _$_PedidoViewModelBaseActionController.startAction(
        name: '_PedidoViewModelBase.finalizarPedido');
    try {
      return super.finalizarPedido();
    } finally {
      _$_PedidoViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic carregarListaDeProdutos(MesaModel mesa) {
    final _$actionInfo = _$_PedidoViewModelBaseActionController.startAction(
        name: '_PedidoViewModelBase.carregarListaDeProdutos');
    try {
      return super.carregarListaDeProdutos(mesa);
    } finally {
      _$_PedidoViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  double calcularTotalHistorico() {
    final _$actionInfo = _$_PedidoViewModelBaseActionController.startAction(
        name: '_PedidoViewModelBase.calcularTotalHistorico');
    try {
      return super.calcularTotalHistorico();
    } finally {
      _$_PedidoViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
historico: ${historico},
pedido: ${pedido}
    ''';
  }
}
