import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/form_produto.dart';
import 'package:lista_compras/componentes/item_produto.dart';
import 'package:lista_compras/componentes/mensagem_lista_vazia.dart';
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
        elevation: 0,
        title: Text(lista.nome),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) => FormProduto(
              usuario: usuario,
              lista: lista,
              produto: null,
            ),
          );
        },
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          color: Theme.of(context).primaryColor,
          child: Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: StreamBuilder(
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
                if (snapshots.data.documents.length == 0) {
                  return MensagemListaVazia('Nenhum produto adicionado');
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
          ),
        );
      }),
    );
  }
}
