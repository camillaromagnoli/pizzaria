import 'package:flutter_modular/flutter_modular.dart';
import 'package:pizzaria/app/features/pedido/views/detalhes_pedido.view.dart';
import 'package:pizzaria/app/features/pedido/views/historico.view.dart';
import '../viewmodel/pedido.viewmodel.dart';
import '../views/registrar_pedido.view.dart';

class PedidoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<PedidoViewModel>((i) => PedidoViewModel()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HistoricoView()),
    ChildRoute('/registrar-pedido',
        child: (_, args) => RegistrarPedidoView(mesa: args.data)),
    ChildRoute('/pedido',
        child: (_, args) => DetalhesPedidoView(index: args.data)),
  ];
}
