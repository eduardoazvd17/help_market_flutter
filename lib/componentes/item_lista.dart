import 'package:flutter/material.dart';

class ItemLista extends StatelessWidget {
  final String titulo;
  final DateTime data;
  final Function onTap;
  final Function onEditar;
  final Function onExcluir;
  ItemLista({
    this.titulo,
    this.data,
    this.onEditar,
    this.onExcluir,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            child: Icon(Icons.list),
          ),
          title: Text(titulo),
          subtitle: Text(data.toString()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: onEditar,
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
                          content: Text('Deseja realmente excluir a lista: ?'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                onExcluir();
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
