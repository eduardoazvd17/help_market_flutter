import 'package:flutter/material.dart';

class ItemConfiguracao extends StatelessWidget {
  final String idUsuario;
  final String idConfiguracao;
  final String titulo;
  final bool valor;
  ItemConfiguracao({
    @required this.idUsuario,
    @required this.idConfiguracao,
    @required this.titulo,
    @required this.valor,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitchListTile(
          value: valor,
          onChanged: (valor) {
            //TODO: Armazenar dados alterados.
          },
          title: Text(titulo),
        ),
        Divider(),
      ],
    );
  }
}
