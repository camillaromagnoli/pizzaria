import 'package:flutter_modular/flutter_modular.dart';
import 'package:pizzaria/app/features/pedido/viewmodel/pedido.viewmodel.dart';
import 'features/home/module/home.module.dart';
import 'features/mesa/viewmodel/mesa.viewmodel.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<MesaViewModel>((i) => MesaViewModel()),
    Bind.lazySingleton<PedidoViewModel>((i) => PedidoViewModel()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];
}
