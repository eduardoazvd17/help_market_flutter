import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/item_lista.dart';
import 'package:lista_compras/modelos/usuario.dart';

class TelaListas extends StatelessWidget {
  final Usuario usuario;
  TelaListas(this.usuario);

  _onTap() {}
  _onEditar() {}
  _onExcluir() {}

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
        if (!snapshots.hasData) {
          return Center(
            child: Text('Nenhuma lista criada'),
          );
        }
        return ListView.builder(
          itemCount: snapshots.data.documents.length,
          itemBuilder: (context, index) {
            DocumentSnapshot doc = snapshots.data.documents[index];
            return ItemLista(
              titulo: doc['nome'],
              data: (doc['data'] as Timestamp).toDate(),
              onTap: _onTap,
              onEditar: _onEditar,
              onExcluir: _onExcluir,
            );
          },
        );
      },
    );
  }
}
