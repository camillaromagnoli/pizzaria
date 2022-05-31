// @dart = 2.9
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pizzaria/app/app.module.dart';
import 'package:pizzaria/app/features/mesa/module/mesa.module.dart';
import 'package:pizzaria/app/features/mesa/viewmodel/mesa.viewmodel.dart';

void main() {
  MesaViewModel viewmodel;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    initModules([MesaModule(), AppModule()], replaceBinds: []);
    viewmodel = Modular.get();
    await viewmodel.registrarMesa(1);
  });

  tearDownAll(() {
    viewmodel.dispose();
  });

  group('MesaViewModel tests ...', () {
    test("Deve registrar uma nova mesa", () async {
      await viewmodel.registrarMesa(2);
      expect(viewmodel.mesas.length, 2);
    });

    test("Deve alterar a disponibilidade de uma mesa", () async {
      await viewmodel.alterarDisponibilidade(0);
      expect(viewmodel.mesas[0].ocupado, true);
    });
  });
}
