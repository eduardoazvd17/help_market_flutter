import 'package:flutter/material.dart';
import 'package:lista_compras/modelos/usuario.dart';

class TelaAjustesConta extends StatelessWidget {
  final Usuario usuario;
  final Function(Usuario) atualizarUsuario;
  TelaAjustesConta(this.usuario, this.atualizarUsuario);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(usuario.nome),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
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
                child: LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.person,
                              size: constraints.maxHeight * 0.25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.edit,
                                      color: Theme.of(context).accentColor),
                                  onPressed: () {}),
                              SizedBox(width: 20),
                              IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ));
  }
}
