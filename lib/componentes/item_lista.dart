import 'package:flutter/material.dart';

class ItemLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.list),
          ),
          title: Text('Lista de Compra'),
          subtitle: Text(DateTime.now().toString()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  //TODO: Edita a lista.
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
                          content: Text('Deseja realmente excluir a lista: ?'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                //TODO: Deleta a lista.
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
