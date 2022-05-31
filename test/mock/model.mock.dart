import 'package:mobx/mobx.dart';
import 'package:pizzaria/app/features/mesa/model/mesa.model.dart';
import 'package:pizzaria/app/features/pedido/model/historico.model.dart';
import 'package:pizzaria/app/features/pedido/model/pedido.model.dart';
import 'package:pizzaria/app/features/pedido/model/produto.model.dart';

final MesaModel mesaLivreModelMock = MesaModel(numero: 1, ocupado: false);

final MesaModel mesaOcupadaModelMock = MesaModel(numero: 2, ocupado: true);

final ObservableList<MesaModel> mesaListWithOneItem =
    ObservableList.of([mesaOcupadaModelMock]);

final ObservableList<MesaModel> mesaListWithNItemsMock =
    ObservableList.of([mesaLivreModelMock, mesaOcupadaModelMock]);

final ObservableList<MesaModel> mesaEmptyListMock = ObservableList.of([]);

final ProdutoModel produtoModelMock =
    ProdutoModel(nome: 'Pizza', quantidade: 1, preco: 50);

final PedidoModel pedidoEmptyModelMock =
    PedidoModel(produtos: [], mesa: mesaOcupadaModelMock);

final PedidoModel pedidoModelMock = PedidoModel(
    produtos: [produtoModelMock, produtoModelMock], mesa: mesaOcupadaModelMock);

final PedidoModel pedidoModelWithOneItemMock =
    PedidoModel(produtos: [produtoModelMock], mesa: mesaOcupadaModelMock);

final List<PedidoModel> pedidosAtivosEmptyModelMock = [];

final List<PedidoModel> pedidosAtivosModelMock = [pedidoModelMock];

final HistoricoModel historicoModelMock =
    HistoricoModel(total: 30, pedido: pedidoModelMock, horario: '18:00');

final ObservableList<HistoricoModel> listHistoricoMock =
    ObservableList.of([historicoModelMock, historicoModelMock]);

final ObservableList<HistoricoModel> listHistoricoWithOneItemMock =
    ObservableList.of([historicoModelMock]);

final ObservableList<HistoricoModel> listHistoricoEmptyMock =
    ObservableList.of([]);
