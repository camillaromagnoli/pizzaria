import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pizzaria/app/features/mesa/viewmodel/mesa.viewmodel.dart';

class MesaView extends StatefulWidget {
  const MesaView({Key? key}) : super(key: key);

  @override
  _MesaViewState createState() => _MesaViewState();
}

class _MesaViewState extends State<MesaView> {
  final MesaViewModel viewmodel = Modular.get();
  final TextEditingController _numeroMesaController = TextEditingController();
  final GlobalKey<FormFieldState> _formFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesas'),
      ),
      body: Observer(builder: (_) {
        return viewmodel.mesas.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(
                          'Mesa ${viewmodel.mesas[index].numero.toString()}'),
                      leading: IconButton(
                        icon: Icon(
                          Icons.circle,
                          color: viewmodel.mesas[index].ocupado
                              ? Colors.red
                              : Colors.green,
                        ),
                        onPressed: () {
                          viewmodel.alterarDisponibilidade(index);
                        },
                      ),
                      trailing: viewmodel.mesas[index].ocupado
                          ? IconButton(
                              icon: const Icon(Icons.list_alt),
                              onPressed: () {
                                Modular.to.pushNamed(
                                    '/pedidos/registrar-pedido',
                                    arguments: viewmodel.mesas[index]);
                              },
                            )
                          : null);
                },
                itemCount: viewmodel.mesas.length,
              )
            : const Center(
                child: Text('Nenhuma mesa cadastrada!'),
              );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _abrirFormularioMesa();
          },
          child: const Icon(Icons.add)),
    );
  }

  _abrirFormularioMesa() {
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              key: _formFieldKey,
              controller: _numeroMesaController,
              decoration: const InputDecoration(label: Text('Número')),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Digite o número da mesa";
                }
                if (viewmodel.mesas
                    .any((element) => element.numero == int.parse(value))) {
                  return "Mesa já cadastrada";
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formFieldKey.currentState!.validate()) {
                  viewmodel
                      .registrarMesa(int.parse(_numeroMesaController.text));
                  Modular.to.pop();
                  _numeroMesaController.clear();
                }
              },
              child: const Text('Salvar'),
            )
          ],
        );
      },
    );
  }
}
