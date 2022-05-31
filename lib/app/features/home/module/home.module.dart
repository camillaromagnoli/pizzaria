import 'package:flutter_modular/flutter_modular.dart';

import '../../mesa/module/mesa.module.dart';
import '../../pedido/module/pedido.module.dart';
import '../views/home.view.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomeView()),
    ModuleRoute('/mesas', module: MesaModule()),
    ModuleRoute('/pedidos', module: PedidoModule()),
  ];
}
