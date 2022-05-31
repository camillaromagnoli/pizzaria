// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mesa.viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MesaViewModel on _MesaViewModelBase, Store {
  late final _$mesasAtom =
      Atom(name: '_MesaViewModelBase.mesas', context: context);

  @override
  ObservableList<MesaModel> get mesas {
    _$mesasAtom.reportRead();
    return super.mesas;
  }

  @override
  set mesas(ObservableList<MesaModel> value) {
    _$mesasAtom.reportWrite(value, super.mesas, () {
      super.mesas = value;
    });
  }

  late final _$_MesaViewModelBaseActionController =
      ActionController(name: '_MesaViewModelBase', context: context);

  @override
  dynamic registrarMesa(int numero) {
    final _$actionInfo = _$_MesaViewModelBaseActionController.startAction(
        name: '_MesaViewModelBase.registrarMesa');
    try {
      return super.registrarMesa(numero);
    } finally {
      _$_MesaViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alterarDisponibilidade(int index) {
    final _$actionInfo = _$_MesaViewModelBaseActionController.startAction(
        name: '_MesaViewModelBase.alterarDisponibilidade');
    try {
      return super.alterarDisponibilidade(index);
    } finally {
      _$_MesaViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mesas: ${mesas}
    ''';
  }
}
