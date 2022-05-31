import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String routeName;

  const MenuItem({Key? key, required this.title, required this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: const BorderRadius.all(Radius.circular(24))),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      onTap: () => Modular.to.pushNamed(routeName),
    );
  }
}
