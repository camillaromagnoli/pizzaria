// @dart = 2.9
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pizzaria/app/app.module.dart';
import 'package:pizzaria/app/features/pedido/model/pedido.model.dart';
import 'package:pizzaria/app/features/pedido/module/pedido.module.dart';
import 'package:pizzaria/app/features/pedido/viewmodel/pedido.viewmodel.dart';

import '../../../../mock/model.mock.dart';

void main() {
  PedidoViewModel viewmodel;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    initModules([PedidoModule(), AppModule()], replaceBinds: []);
    viewmodel = Modular.get();
  });

  setUp(() {
    viewmodel.pedido = PedidoModel(
        produtos: List.from(pedidoModelMock.produtos),
        mesa: pedidoModelMock.mesa);
    viewmodel.pedidosAtivos = ObservableList<PedidoModel>.of([]);
  });

  tearDownAll(() {
    viewmodel.dispose();
  });

  tearDown(() {
    Modular.dispose();
    viewmodel.pedido = null;
  });

  group('PedidoViewModel tests ...', () {
    test("Deve calcular o valor total do pedido", () {
      viewmodel.pedido = pedidoModelMock;
      expect(viewmodel.calcularTotalPedido(), 100);
    });
    test("Deve adicionar um produto", () async {
      viewmodel.adicionarProduto(nome: 'Pizza', quantidade: 1, preco: 50);
      expect(viewmodel.pedido.produtos[1].nome, 'Pizza');
    });
    test("Deve finalizar o pedido", () {
      viewmodel.finalizarPedido();
      expect(viewmodel.historico.isNotEmpty, true);
      expect(viewmodel.pedido.produtos.isEmpty, true);
    });
    test("Deve remover um produto do pedido", () {
      viewmodel.removerProduto(0);
      expect(viewmodel.pedido.produtos.length, 1);
    });
    test("Deve carregar a lista de produtos de um pedido existente", () {
      viewmodel.pedidosAtivos = pedidosAtivosModelMock;
      viewmodel.carregarListaDeProdutos(mesaOcupadaModelMock);
      expect(viewmodel.pedido, isNotNull);
      expect(viewmodel.pedido.mesa.numero, mesaOcupadaModelMock.numero);
    });
    test(
        "Deve instanciar um novo pedido quando nao existir pedido ativo para a mesa",
        () {
      viewmodel.pedido = null;
      viewmodel.carregarListaDeProdutos(mesaOcupadaModelMock);
      expect(viewmodel.pedido, isNotNull);
      expect(viewmodel.pedido.produtos, isEmpty);
    });
    test("Deve calcular o total do histórico de pedidos", () {
      viewmodel.historico = listHistoricoMock;
      expect(viewmodel.calcularTotalHistorico(), 60);
    });
  });
}
