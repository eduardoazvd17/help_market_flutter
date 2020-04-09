import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/item_configuracao.dart';
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
        if (!snapshots.hasData) {
          return Center(
            child: Text('Nenhuma lista criada'),
          );
        }
        return ListView.builder(
          itemCount: 1,
          itemBuilder: (ctx, index) {
            DocumentSnapshot doc = snapshots.data.documents[index];
            var config = Config(doc.documentID, doc['nome'], doc['valor']);
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
