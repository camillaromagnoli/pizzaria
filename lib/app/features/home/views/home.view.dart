import 'package:flutter/material.dart';

import '../components/menu_item.widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: const [
          MenuItem(
            key: Key('menu_item_mesa_key'),
            title: 'Mesas',
            routeName: '/mesas',
          ),
          MenuItem(
            title: 'Histórico',
            routeName: '/pedidos',
          )
        ],
      ),
    );
  }
}
