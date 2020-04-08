import 'package:flutter/material.dart';

class ItemDrawer extends StatelessWidget {
  final String titulo;
  final Icon icone;
  final Function onTap;

  ItemDrawer({
    @required this.titulo,
    @required this.onTap,
    this.icone,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: icone,
        title: Text(titulo),
      ),
    );
  }
}
