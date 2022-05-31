import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../model/mesa.model.dart';

part 'mesa.viewmodel.g.dart';

class MesaViewModel extends _MesaViewModelBase
    with _$MesaViewModel, Disposable {
  @override
  void dispose() {}
}

abstract class _MesaViewModelBase with Store {
  @observable
  ObservableList<MesaModel> mesas = ObservableList.of([]);

  @action
  registrarMesa(int numero) {
    mesas.add(MesaModel(numero: numero, ocupado: false));
  }

  @action
  alterarDisponibilidade(int index) {
    mesas[index] =
        MesaModel(numero: mesas[index].numero, ocupado: !mesas[index].ocupado);
  }
}
