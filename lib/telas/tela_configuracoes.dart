import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/item_configuracao.dart';
import 'package:lista_compras/componentes/mensagem_lista_vazia.dart';
import 'package:lista_compras/modelos/config.dart';
import 'package:lista_compras/modelos/usuario.dart';

//collection user.document id. collection  config
class TelaConfiguracoes extends StatelessWidget {
  final Usuario usuario;
  TelaConfiguracoes(this.usuario);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('usuarios')
          .document(usuario.id)
          .collection('config')
          .snapshots(),
      builder: (context, snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshots.data.documents.length,
          itemBuilder: (ctx, index) {
            DocumentSnapshot doc = snapshots.data.documents[index];
            Config config = new Config(
              doc.documentID,
              doc['nome'],
              doc['valor'] as bool,
            );
            return ItemConfiguracao(
              usuario: usuario,
              config: config,
            );
          },
        );
      },
    );
  }

  _onChange(bool valor) {
    print(valor);
  }
}
