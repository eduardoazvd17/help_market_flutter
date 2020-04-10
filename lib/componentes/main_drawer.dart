import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/item_drawer.dart';
import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/telas/tela_ajustes_conta.dart';
import 'package:lista_compras/telas/tela_cadastro.dart';

class MainDrawer extends StatelessWidget {
  final Usuario usuario;
  final Function(Usuario) atualizarUsuario;
  MainDrawer(this.usuario, this.atualizarUsuario);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(
              width: double.infinity,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.people,
                      size: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      usuario == null
                          ? "Ainda não possui uma conta?"
                          : "${usuario.nome}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      usuario == null
                          ? "Efetue o cadastro no menu abaixo."
                          : "${usuario.email}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Divider(),
                  usuario == null
                      ? Column(
                          children: <Widget>[
                            ItemDrawer(
                              icone: Icon(Icons.exit_to_app),
                              titulo: "Entrar",
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Divider(),
                            ItemDrawer(
                              icone: Icon(Icons.person_add),
                              titulo: "Cadastrar-se",
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        TelaCadastro(atualizarUsuario),
                                  ),
                                );
                              },
                            ),
                            Divider(),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            ItemDrawer(
                              icone: Icon(Icons.settings),
                              titulo: "Ajustes da Conta",
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => TelaAjustesConta(
                                      usuario,
                                      atualizarUsuario,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Divider(),
                            ItemDrawer(
                              icone: Icon(Icons.exit_to_app),
                              titulo: "Finalizar Sessão",
                              onTap: () {
                                FirebaseAuth.instance.signOut();
                                atualizarUsuario(null);
                                Navigator.of(context).pop();
                              },
                            ),
                            Divider(),
                          ],
                        ),
                ],
              ),
              Column(
                children: <Widget>[
                  ItemDrawer(
                    titulo: "Sobre-nós",
                    onTap: () {},
                  ),
                  ItemDrawer(
                    titulo: "Privacidade",
                    onTap: () {},
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
