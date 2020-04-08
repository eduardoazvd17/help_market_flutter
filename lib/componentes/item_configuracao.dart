import 'package:flutter/material.dart';

class ItemConfiguracao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitchListTile(
          value: false,
          onChanged: (valor) {
            //TODO: Armazena dados alterados.
          },
          title: Text('titulo'),
        ),
        Divider(),
      ],
    );
  }
}
