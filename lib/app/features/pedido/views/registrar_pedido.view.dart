import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pizzaria/app/features/pedido/model/produto.model.dart';
import 'package:pizzaria/app/features/pedido/viewmodel/pedido.viewmodel.dart';

import '../../mesa/model/mesa.model.dart';

class RegistrarPedidoView extends StatefulWidget {
  final MesaModel mesa;
  const RegistrarPedidoView({Key? key, required this.mesa}) : super(key: key);

  @override
  _RegistrarPedidoViewState createState() => _RegistrarPedidoViewState();
}

class _RegistrarPedidoViewState extends State<RegistrarPedidoView> {
  final PedidoViewModel viewmodel = Modular.get();
  final TextEditingController _nomeProdutoController = TextEditingController();
  final TextEditingController _quantidadeProdutoController =
      TextEditingController();
  final TextEditingController _precoProdutoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    viewmodel.carregarListaDeProdutos(widget.mesa);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido da Mesa ${widget.mesa.numero.toString()}'),
        actions: [
          IconButton(
              onPressed: () => _finalizarPedido(),
              icon: const Icon(Icons.check))
        ],
      ),
      body: viewmodel.pedido != null && viewmodel.pedido!.produtos.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                ProdutoModel produto = viewmodel.pedido!.produtos[index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Text(
                      'Quantidade: ${produto.quantidade.toString()} - Preço: R\$ ${produto.preco.toString()}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      viewmodel.removerProduto(index);
                    },
                  ),
                );
              },
              itemCount: viewmodel.pedido!.produtos.length,
            )
          : const Center(
              child: Text('Nenhum produto cadastrado!'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _adicionarProduto();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _adicionarProduto() {
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
            contentPadding: const EdgeInsets.all(16),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      key: const Key('nome_produto_key'),
                      controller: _nomeProdutoController,
                      decoration: const InputDecoration(label: Text('Nome')),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Digite o nome do produto";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      key: const Key('quantidade_produto_key'),
                      controller: _quantidadeProdutoController,
                      decoration:
                          const InputDecoration(label: Text('Quantidade')),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Digite a quantidade";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      key: const Key('preco_produto_key'),
                      controller: _precoProdutoController,
                      decoration: const InputDecoration(label: Text('Preço')),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Digite o preço";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      key: const Key('salvar_produto_button_key'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          viewmodel.adicionarProduto(
                            nome: _nomeProdutoController.text,
                            quantidade:
                                int.parse(_quantidadeProdutoController.text),
                            preco: double.parse(_precoProdutoController.text),
                          );
                          Modular.to.pop();
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
              ),
            ]);
      },
    );
  }

  _finalizarPedido() {
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(24),
          children: [
            const Text('Fechar pedido?'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  key: const Key('cancelar_finalizar_pedido_key'),
                  onPressed: () => Modular.to.pop(),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  key: const Key('finalizar_pedido_key'),
                  onPressed: () {
                    viewmodel.finalizarPedido();
                    Modular.to.pop();
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
