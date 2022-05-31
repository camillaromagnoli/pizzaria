import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'Pizzaria Sr. José',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Rubik'),
      debugShowCheckedModeBanner: false,
    );
  }
}
