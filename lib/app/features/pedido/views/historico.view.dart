import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pizzaria/app/features/pedido/viewmodel/pedido.viewmodel.dart';

class HistoricoView extends StatefulWidget {
  const HistoricoView({Key? key}) : super(key: key);

  @override
  _HistoricoViewState createState() => _HistoricoViewState();
}

class _HistoricoViewState extends State<HistoricoView> {
  final PedidoViewModel viewmodel = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
      ),
      body: Observer(builder: (_) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Pedido ${index + 1}'),
                    subtitle: Text(
                        'Total: ${viewmodel.historico[index].total.toString()} - Horário: ${viewmodel.historico[index].horario}'),
                    onTap: () {
                      Modular.to.pushNamed('/pedidos/pedido', arguments: index);
                    },
                  );
                },
                itemCount: viewmodel.historico.length,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.topLeft,
              child: Text(
                'Total: R\$ ${viewmodel.calcularTotalHistorico()}',
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        );
      }),
    );
  }
}
