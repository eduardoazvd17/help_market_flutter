import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/item_drawer.dart';
import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/telas/tela_ajustes_conta.dart';
import 'package:lista_compras/telas/tela_cadastro.dart';
import 'package:lista_compras/utilitarios/validador.dart';

class MainDrawer extends StatelessWidget {
  final Usuario usuario;
  final Function(Usuario) atualizarUsuario;
  MainDrawer(this.usuario, this.atualizarUsuario);
  @override
  Widget build(BuildContext context) {
    var largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                child: Container(
                  width: double.infinity,
                  height: largura * 0.4,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: usuario == null
                              ? Container(
                                  width: largura * 0.2,
                                  height: largura * 0.2,
                                  color: Theme.of(context).primaryColor,
                                  child: Icon(Icons.person,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      size: largura * 0.2),
                                )
                              : usuario.fotoUrl == null
                                  ? Container(
                                      width: largura * 0.2,
                                      height: largura * 0.2,
                                      color: Theme.of(context).primaryColor,
                                      child: Icon(Icons.person,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          size: largura * 0.2),
                                    )
                                  : Image.network(
                                      usuario.fotoUrl,
                                      width: largura * 0.2,
                                      height: largura * 0.2,
                                      fit: BoxFit.cover,
                                    ),
                        ),
                        SizedBox(height: 10),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Divider(),
                      usuario == null
                          ? Column(
                              children: <Widget>[
                                ItemDrawer(
                                  icone: Icon(
                                    Icons.exit_to_app,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  titulo: "Entrar",
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Divider(),
                                ItemDrawer(
                                  icone: Icon(
                                    Icons.person_add,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
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
                                  icone: Icon(
                                    Icons.settings,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  titulo: "Ajustes da Conta",
                                  onTap: () {
                                    FirebaseAuth.instance
                                        .currentUser()
                                        .then((user) {
                                      user.reload();
                                      if (user.isEmailVerified) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => TelaAjustesConta(
                                              usuario,
                                              atualizarUsuario,
                                            ),
                                          ),
                                        );
                                      } else {
                                        Validador(context).dialogoVerficarEmail(
                                            "Seu e-mail ainda não foi verificado, para verificar clique no link que lhe enviamos por e-mail.");
                                      }
                                    });
                                  },
                                ),
                                Divider(),
                                ItemDrawer(
                                  icone: Icon(
                                    Icons.exit_to_app,
                                    color: Colors.red,
                                  ),
                                  titulo: "Finalizar Sessão",
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: new Text("Finalizar Sessão"),
                                          content: new Text(
                                              "Deseja realmente sair?"),
                                          actions: <Widget>[
                                            new FlatButton(
                                              child: new Text("Sim"),
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                                atualizarUsuario(null);
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            new FlatButton(
                                              child: new Text("Não"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
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
        ),
      ),
    );
  }
}
