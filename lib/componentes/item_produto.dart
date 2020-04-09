import 'package:flutter/material.dart';
import 'package:lista_compras/modelos/lista.dart';
import 'package:lista_compras/modelos/produto.dart';
import 'package:lista_compras/modelos/usuario.dart';

class ItemProduto extends StatelessWidget {
  final Usuario usuario;
  final Lista lista;
  final Produto produto;
  ItemProduto({
    this.usuario,
    this.lista,
    this.produto,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: FittedBox(
              child: Text(
                '${produto.quantidade}x',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          title: Text(produto.nome),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  //TODO: Edita o produto.
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
                          title: Text('Excluir Produto'),
                          content: Text(
                              'Deseja realmente excluir o produto: ${produto.nome}?'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                //TODO: Exclui o produto
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
