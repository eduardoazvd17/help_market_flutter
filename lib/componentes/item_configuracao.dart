import 'package:flutter/material.dart';
import 'package:lista_compras/modelos/config.dart';
import 'package:lista_compras/modelos/usuario.dart';

class ItemConfiguracao extends StatelessWidget {
  final Usuario usuario;
  final Config config;

  ItemConfiguracao({this.usuario, this.config});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitchListTile(
          value: config.valor,
          onChanged: (valor) {
            //TODO: Altera no firebase
          },
          title: Text(config.nome),
        ),
        Divider(),
      ],
    );
  }
}
