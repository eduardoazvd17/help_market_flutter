import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/botao_ajustes.dart';
import 'package:lista_compras/componentes/form_ajustes_conta.dart';
import 'package:lista_compras/modelos/usuario.dart';

class TelaAjustesConta extends StatelessWidget {
  final Usuario usuario;
  final Function(Usuario) atualizarUsuario;
  TelaAjustesConta(this.usuario, this.atualizarUsuario);

  _abrirModal(context, int opcao) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => FormAjustesConta(
        usuario: usuario,
        atualizarUsuario: atualizarUsuario,
        opcao: opcao,
      ),
    );
  }

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
                var altura = constraints.maxHeight;
                var largura = constraints.maxWidth;
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 35, bottom: 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  ClipOval(
                                    child: Container(
                                      height: altura * 0.25,
                                      width: largura * 0.4,
                                      color: Colors.green,
                                      child: Icon(
                                        Icons.person,
                                        size: altura * 0.2,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                          icon: Icon(Icons.edit,
                                              color: Theme.of(context)
                                                  .accentColor),
                                          onPressed: () {}),
                                      IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      BotaoAjustes(
                        titulo: "Alterar Nome",
                        icone: Icons.mail,
                        funcao: () => _abrirModal(context, 0),
                      ),
                      BotaoAjustes(
                        titulo: "Alterar E-mail",
                        icone: Icons.mail,
                        funcao: () => _abrirModal(context, 1),
                      ),
                      BotaoAjustes(
                        titulo: "Alterar Senha",
                        icone: Icons.mail,
                        funcao: () => _abrirModal(context, 2),
                      ),
                    ],
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
