import 'package:flutter/material.dart';
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
          subtitle: Text(lista.data.toString()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  //TODO: Edita a lista
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
                              'Deseja realmente excluir a lista: ${lista.nome}?'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                //TODO: Exclui a lista
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
}
