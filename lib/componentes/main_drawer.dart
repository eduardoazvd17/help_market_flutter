import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/listTile_inkWell.dart';

class MainDrawer extends StatelessWidget {
  final String nome;
  final String email;

  MainDrawer({
    this.email,
    this.nome,
  });

  //TODO: adicionar funcionalidade aos botoes do drawer.

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: ThemeData().primaryColor,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(
              width: double.infinity,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: ThemeData().primaryColor,
                ),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.people,
                      size: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      "Desenvolvedor",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "dev@development.com",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Divider(),
                ListTileInkWell(
                  icon: Icon(Icons.settings),
                  text: "Configurações",
                  function: () {},
                ),
                Divider(),
                ListTileInkWell(
                  text: "Sobre-nós",
                  function: () {},
                ),
                ListTileInkWell(
                  text: "Privacidade",
                  function: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
