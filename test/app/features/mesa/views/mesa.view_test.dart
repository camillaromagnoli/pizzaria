// @dart = 2.9
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pizzaria/app/app.module.dart';
import 'package:pizzaria/app/features/mesa/module/mesa.module.dart';
import 'package:pizzaria/app/features/mesa/viewmodel/mesa.viewmodel.dart';
import 'package:pizzaria/app/features/mesa/views/mesa.view.dart';

import '../../../../mock/model.mock.dart';
import '../../../../mock/services.mock.dart';
import '../../../../mock/utils/pump_mediaquery_material.dart';
import '../../../../mock/viewmodel.mock.dart';

void main() {
  final viewmodelMock = MesaViewModelMock();
  final navigatorMock = ModularNavigateMock();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    initModules(
      [AppModule(), MesaModule()],
      replaceBinds: [
        Bind<MesaViewModel>((_) => viewmodelMock),
      ],
    );
    Modular.navigatorDelegate = navigatorMock;
  });

  tearDown(() {
    Modular.dispose();
  });
  group('MesaView tests...', () {
    testWidgets('Deve exibir as mesas quando a lista não estiver vazia',
        (tester) async {
      when(viewmodelMock.mesas).thenReturn(mesaListWithNItemsMock);
      await pumpWidgetWithMediaQueryAndMaterialApp(tester, const MesaView());

      final mesasListView = find.byType(ListView);
      expect(mesasListView, findsOneWidget);

      final listTileItem = find.byType(ListTile);
      expect(listTileItem, findsNWidgets(mesaListWithNItemsMock.length));
    });
    testWidgets('Deve alterar a disponibilidade de uma mesa', (tester) async {
      when(viewmodelMock.mesas).thenReturn(mesaListWithOneItem);
      await pumpWidgetWithMediaQueryAndMaterialApp(tester, const MesaView());

      final mesasListView = find.byType(ListView);
      expect(mesasListView, findsOneWidget);

      final disponibilidadeIcon = find.ancestor(
          of: find.byIcon(Icons.circle), matching: find.byType(IconButton));
      expect(disponibilidadeIcon, findsOneWidget);

      await tester.tap(disponibilidadeIcon);
      await tester.pumpAndSettle();

      verify(viewmodelMock.alterarDisponibilidade(any)).called(1);
    });
    testWidgets('Deve ir para o pedido ao clicar no icone', (tester) async {
      when(viewmodelMock.mesas).thenReturn(mesaListWithOneItem);
      await pumpWidgetWithMediaQueryAndMaterialApp(tester, const MesaView());

      final mesasListView = find.byType(ListView);
      expect(mesasListView, findsOneWidget);

      final pedidoIcon = find.ancestor(
          of: find.byIcon(Icons.list_alt), matching: find.byType(IconButton));
      expect(pedidoIcon, findsOneWidget);

      await tester.tap(pedidoIcon);
      await tester.pumpAndSettle();

      verify(navigatorMock.pushNamed('/pedidos/registrar-pedido',
              arguments: mesaOcupadaModelMock))
          .called(1);
    });
    testWidgets('Deve registrar uma nova mesa', (tester) async {
      when(viewmodelMock.mesas).thenReturn(mesaEmptyListMock);
      await pumpWidgetWithMediaQueryAndMaterialApp(tester, const MesaView());

      final floatingActionButton = find.byType(FloatingActionButton);
      expect(floatingActionButton, findsOneWidget);

      await tester.tap(floatingActionButton);
      await tester.pumpAndSettle();

      final novaMesaDialog = find.byType(SimpleDialog);
      expect(novaMesaDialog, findsOneWidget);

      final numeroMesaTextFormField = find.byType(TextFormField);
      expect(numeroMesaTextFormField, findsOneWidget);

      await tester.enterText(numeroMesaTextFormField, '10');
      await tester.pumpAndSettle();

      final saveButton = find.byType(ElevatedButton);
      expect(saveButton, findsOneWidget);

      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      verify(viewmodelMock.registrarMesa(any)).called(1);
      verify(navigatorMock.pop()).called(1);
    });
  });
}
