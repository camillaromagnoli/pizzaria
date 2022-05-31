// @dart = 2.9
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pizzaria/app/app.module.dart';
import 'package:pizzaria/app/features/pedido/module/pedido.module.dart';
import 'package:pizzaria/app/features/pedido/viewmodel/pedido.viewmodel.dart';
import 'package:pizzaria/app/features/pedido/views/registrar_pedido.view.dart';

import '../../../../mock/model.mock.dart';
import '../../../../mock/services.mock.dart';
import '../../../../mock/utils/pump_mediaquery_material.dart';
import '../../../../mock/viewmodel.mock.dart';

void main() {
  PedidoViewModelMock viewmodelMock = PedidoViewModelMock();
  final navigatorMock = ModularNavigateMock();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    initModules(
      [AppModule(), PedidoModule()],
      replaceBinds: [
        Bind<PedidoViewModel>((_) => viewmodelMock),
      ],
    );
    Modular.navigatorDelegate = navigatorMock;
  });

  tearDown(() {
    Modular.dispose();
    reset(navigatorMock);
  });

  group('RegistrarPedidoView tests...', () {
    testWidgets('Deve deletar um produto da lista', (tester) async {
      when(viewmodelMock.pedido).thenReturn(pedidoModelWithOneItemMock);
      await pumpWidgetWithMediaQueryAndMaterialApp(
          tester,
          RegistrarPedidoView(
            mesa: mesaOcupadaModelMock,
          ));
      final deleteIcon = find.ancestor(
          of: find.byIcon(Icons.delete), matching: find.byType(IconButton));
      expect(deleteIcon, findsOneWidget);

      await tester.tap(deleteIcon);
      await tester.pumpAndSettle();

      verify(viewmodelMock.removerProduto(any)).called(1);
    });

    testWidgets('Deve adicionar um novo produto', (tester) async {
      when(viewmodelMock.pedido).thenReturn(pedidoEmptyModelMock);
      await pumpWidgetWithMediaQueryAndMaterialApp(
          tester,
          RegistrarPedidoView(
            mesa: mesaOcupadaModelMock,
          ));

      final floatingActionButton = find.byType(FloatingActionButton);
      expect(floatingActionButton, findsOneWidget);

      await tester.tap(floatingActionButton);
      await tester.pumpAndSettle();

      final novoProdutoDialog = find.byType(SimpleDialog);
      expect(novoProdutoDialog, findsOneWidget);

      final nomeProdutoTextField = find.byKey(const Key('nome_produto_key'));
      expect(nomeProdutoTextField, findsOneWidget);

      await tester.enterText(nomeProdutoTextField, 'Pizza');
      await tester.pumpAndSettle();

      final quantidadeProdutoTextField =
          find.byKey(const Key('quantidade_produto_key'));
      expect(quantidadeProdutoTextField, findsOneWidget);

      await tester.enterText(quantidadeProdutoTextField, '2');
      await tester.pumpAndSettle();

      final precoProdutoTextField = find.byKey(const Key('preco_produto_key'));
      expect(precoProdutoTextField, findsOneWidget);

      await tester.enterText(precoProdutoTextField, '50');
      await tester.pumpAndSettle();

      final salvarProdutoButton =
          find.byKey(const Key('salvar_produto_button_key'));
      expect(salvarProdutoButton, findsOneWidget);

      await tester.tap(salvarProdutoButton);
      await tester.pumpAndSettle();

      verify(
        viewmodelMock.adicionarProduto(
          nome: anyNamed('nome'),
          quantidade: anyNamed('quantidade'),
          preco: anyNamed('preco'),
        ),
      ).called(1);
    });

    testWidgets('Deve finalizar o pedido', (tester) async {
      when(viewmodelMock.pedido).thenReturn(pedidoModelMock);
      await pumpWidgetWithMediaQueryAndMaterialApp(
          tester,
          RegistrarPedidoView(
            mesa: mesaOcupadaModelMock,
          ));

      await findAndTapFinalizarPedidoIcon(tester);

      final confirmarFinalizarPedidoButton =
          find.byKey(const Key('finalizar_pedido_key'));
      expect(confirmarFinalizarPedidoButton, findsOneWidget);

      await tester.tap(confirmarFinalizarPedidoButton);
      await tester.pumpAndSettle();

      verify(await viewmodelMock.finalizarPedido()).called(1);
      verify(navigatorMock.pop()).called(1);
    });

    testWidgets('Deve cancelar o diálogo de confirmação de pedido',
        (tester) async {
      when(viewmodelMock.pedido).thenReturn(pedidoModelMock);
      await pumpWidgetWithMediaQueryAndMaterialApp(
          tester,
          RegistrarPedidoView(
            mesa: mesaOcupadaModelMock,
          ));

      await findAndTapFinalizarPedidoIcon(tester);

      final cancelarFinalizarPedidoButton =
          find.byKey(const Key('cancelar_finalizar_pedido_key'));
      expect(cancelarFinalizarPedidoButton, findsOneWidget);

      await tester.tap(cancelarFinalizarPedidoButton);
      await tester.pumpAndSettle();

      verify(navigatorMock.pop()).called(1);
    });
  });
}

Future<void> findAndTapFinalizarPedidoIcon(WidgetTester tester) async {
  final finalizarPedidoIcon = find.ancestor(
      of: find.byIcon(Icons.check), matching: find.byType(IconButton));
  expect(finalizarPedidoIcon, findsOneWidget);

  await tester.tap(finalizarPedidoIcon);
  await tester.pumpAndSettle();

  final finalizarPedidoDialog = find.byType(SimpleDialog);
  expect(finalizarPedidoDialog, findsOneWidget);
}
