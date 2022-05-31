// @dart = 2.9
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pizzaria/app/app.module.dart';
import 'package:pizzaria/app/features/home/module/home.module.dart';
import 'package:pizzaria/app/features/home/views/home.view.dart';

import '../../../../mock/services.mock.dart';
import '../../../../mock/utils/pump_mediaquery_material.dart';

void main() {
  final navigatorMock = ModularNavigateMock();
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    initModules(
      [AppModule(), HomeModule()],
    );
    Modular.navigatorDelegate = navigatorMock;
  });

  tearDown(() {
    Modular.dispose();
  });
  group('HomeView tests...', () {
    testWidgets('Deve ir para a tela de mesas', (tester) async {
      await pumpWidgetWithMediaQueryAndMaterialApp(tester, const HomeView());

      final menuItemMesa = find.byKey(const Key('menu_item_mesa_key'));
      expect(menuItemMesa, findsOneWidget);

      await tester.tap(menuItemMesa);
      await tester.pumpAndSettle();

      verify(navigatorMock.pushNamed('/mesas')).called(1);
    });
    testWidgets('Deve ir para a tela de histórico', (tester) async {
      await pumpWidgetWithMediaQueryAndMaterialApp(tester, const HomeView());

      final menuItemHistorico =
          find.byKey(const Key('menu_item_historico_key'));

      expect(menuItemHistorico, findsOneWidget);

      await tester.tap(menuItemHistorico);
      await tester.pumpAndSettle();

      verify(navigatorMock.pushNamed('/pedidos')).called(1);
    });
  });
}
