import 'package:flutter/material.dart';

class ItemConfiguracao extends StatelessWidget {
  final String titulo;
  final bool valor;
  final Function(bool) onChange;
  ItemConfiguracao({this.titulo, this.valor, this.onChange});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitchListTile(
          value: valor,
          onChanged: onChange(valor),
          title: Text(titulo),
        ),
        Divider(),
      ],
    );
  }
}
