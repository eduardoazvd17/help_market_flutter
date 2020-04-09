import 'package:cloud_firestore/cloud_firestore.dart';
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
            Firestore.instance
                .collection('usuarios')
                .document(usuario.id)
                .collection('config')
                .document(config.id)
                .updateData({
              'valor': valor,
            });
          },
          title: Text(config.nome),
        ),
        Divider(),
      ],
    );
  }
}
