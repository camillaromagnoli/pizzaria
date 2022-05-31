import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pizzaria/app/features/pedido/viewmodel/pedido.viewmodel.dart';

import '../model/produto.model.dart';

class DetalhesPedidoView extends StatefulWidget {
  final int index;
  const DetalhesPedidoView({Key? key, required this.index}) : super(key: key);

  @override
  _DetalhesPedidoViewState createState() => _DetalhesPedidoViewState();
}

class _DetalhesPedidoViewState extends State<DetalhesPedidoView> {
  final PedidoViewModel viewmodel = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do pedido ${widget.index + 1}'),
      ),
      body: Observer(builder: (_) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Mesa ${viewmodel.historico[widget.index].pedido.mesa.numero}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  ProdutoModel produto =
                      viewmodel.historico[widget.index].pedido.produtos[index];
                  return ListTile(
                    title: Text(produto.nome),
                    subtitle: Text(
                        'Quantidade: ${produto.quantidade.toString()} - Preço: ${produto.preco}'),
                  );
                },
                itemCount:
                    viewmodel.historico[widget.index].pedido.produtos.length,
              ),
            ),
          ],
        );
      }),
    );
  }
}
