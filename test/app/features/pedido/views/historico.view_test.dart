// @dart = 2.9
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pizzaria/app/app.module.dart';
import 'package:pizzaria/app/features/pedido/module/pedido.module.dart';
import 'package:pizzaria/app/features/pedido/viewmodel/pedido.viewmodel.dart';
import 'package:pizzaria/app/features/pedido/views/historico.view.dart';

import '../../../../mock/model.mock.dart';
import '../../../../mock/services.mock.dart';
import '../../../../mock/utils/pump_mediaquery_material.dart';
import '../../../../mock/viewmodel.mock.dart';

void main() {
  final viewmodelMock = PedidoViewModelMock();
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

  tearDownAll(() {
    Modular.dispose();
  });
  group('HistoricoView tests...', () {
    testWidgets('Deve ir para um pedido', (tester) async {
      when(viewmodelMock.historico).thenReturn(listHistoricoWithOneItemMock);
      await pumpWidgetWithMediaQueryAndMaterialApp(
          tester, const HistoricoView());

      final listTileItem = find.byType(ListTile);
      expect(listTileItem, findsOneWidget);

      await tester.tap(listTileItem);
      await tester.pumpAndSettle();

      verify(navigatorMock.pushNamed('/pedidos/pedido', arguments: 0));
    });
  });
}
