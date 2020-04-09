import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/item_produto.dart';
import 'package:lista_compras/modelos/lista.dart';
import 'package:lista_compras/modelos/produto.dart';
import 'package:lista_compras/modelos/usuario.dart';

class TelaProdutos extends StatelessWidget {
  final Usuario usuario;
  final Lista lista;
  TelaProdutos(this.usuario, this.lista);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lista.nome),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('listas')
            .document(lista.id)
            .collection('produtos')
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshots.hasData) {
            return Center(
              child: Text('Nenhum Produto Adicionado'),
            );
          }
          return ListView.builder(
            itemCount: snapshots.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot doc = snapshots.data.documents[index];
              Produto produto = new Produto(
                doc.documentID,
                doc['nome'],
                doc['quantidade'] as int,
              );
              return ItemProduto(
                usuario: usuario,
                lista: lista,
                produto: produto,
              );
            },
          );
        },
      ),
    );
  }
}
