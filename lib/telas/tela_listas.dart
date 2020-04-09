import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/item_lista.dart';
import 'package:lista_compras/componentes/mensagem_lista_vazia.dart';
import 'package:lista_compras/modelos/lista.dart';
import 'package:lista_compras/modelos/usuario.dart';

class TelaListas extends StatelessWidget {
  final Usuario usuario;
  TelaListas(this.usuario);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('listas')
          .where('autor', isEqualTo: usuario.id)
          .snapshots(),
      builder: (context, snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshots.data.documents.length == 0) {
          return MensagemListaVazia('Nenhuma lista adicionada');
        }
        return ListView.builder(
          itemCount: snapshots.data.documents.length,
          itemBuilder: (context, index) {
            DocumentSnapshot doc = snapshots.data.documents[index];
            Lista lista = new Lista(
              doc.documentID,
              doc['nome'],
              (doc['data'] as Timestamp).toDate(),
            );
            return ItemLista(
              usuario: usuario,
              lista: lista,
            );
          },
        );
      },
    );
  }
}
