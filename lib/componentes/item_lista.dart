import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lista_compras/componentes/form_lista.dart';
import 'package:lista_compras/modelos/lista.dart';
import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/telas/tela_produtos.dart';

class ItemLista extends StatelessWidget {
  final Usuario usuario;
  final Lista lista;
  ItemLista({
    this.usuario,
    this.lista,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TelaProdutos(usuario, lista),
              ),
            );
          },
          leading: CircleAvatar(
            child: Icon(Icons.list),
          ),
          title: Text(lista.nome),
          subtitle: Text(formatarData()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (_) => FormLista(
                      usuario: usuario,
                      lista: lista,
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Excluir Lista'),
                          content: Text(
                              'Deseja realmente excluir a lista: ${lista.nome}?\nTodos os produtos desta lista também serão apagados.'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Firestore.instance
                                    .collection('listas')
                                    .document(lista.id)
                                    .delete();
                                Firestore.instance
                                    .collection('listas')
                                    .document(lista.id)
                                    .collection('produtos')
                                    .getDocuments()
                                    .then((docs) {
                                  for (var doc in docs.documents) {
                                    doc.reference.delete();
                                  }
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Sim'),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Não'),
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  formatarData() {
    initializeDateFormatting("pt_BR", null);
    String dataFormatada = DateFormat('dd MMMM y', 'pt_BR').format(lista.data);
    var from = dataFormatada.split(" ")[1];
    var to = from.replaceFirst(from[0], from[0].toUpperCase());
    return dataFormatada.replaceAll(from, to).replaceAll(" ", " de ");
  }
}
