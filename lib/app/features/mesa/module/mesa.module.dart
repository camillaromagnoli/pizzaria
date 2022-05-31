import 'package:flutter_modular/flutter_modular.dart';

import '../viewmodel/mesa.viewmodel.dart';
import '../views/mesa.view.dart';

class MesaModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<MesaViewModel>((i) => MesaViewModel()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const MesaView()),
  ];
}
