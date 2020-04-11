import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/ajustes_btn.dart';
import 'package:lista_compras/componentes/form_ajustes_conta.dart';
import 'package:lista_compras/modelos/usuario.dart';

class TelaAjustesConta extends StatelessWidget {
  final Usuario usuario;
  final Function(Usuario) atualizarUsuario;
  TelaAjustesConta(this.usuario, this.atualizarUsuario);

  var dadosController = TextEditingController();
  var confirmacaoDadosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;
    var largura = MediaQuery.of(context).size.width;
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
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: altura * 0.04,
                          left: largura * 0.22,
                          right: largura * 0.22,
                        ),
                        padding: EdgeInsets.only(top: altura * 0.04),
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.25),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.person,
                                      size: constraints.maxHeight * 0.25),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                          icon: Icon(Icons.edit,
                                              color: Theme.of(context)
                                                  .accentColor),
                                          onPressed: () {}),
                                      SizedBox(width: 20),
                                      IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      AjustesBtn(
                        texto: "Alterar Nome",
                        icone: Icons.mail,
                        funcao: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (_) => FormAjustesConta(
                              usuario: usuario,
                              opcao: 0,
                            ),
                          );
                        },
                      ),
                      AjustesBtn(
                        texto: "Alterar E-mail",
                        icone: Icons.mail,
                        funcao: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (_) => FormAjustesConta(
                              usuario: usuario,
                              opcao: 1,
                            ),
                          );
                        },
                      ),
                      AjustesBtn(
                        texto: "Alterar Senha",
                        icone: Icons.mail,
                        funcao: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (_) => FormAjustesConta(
                              usuario: usuario,
                              opcao: 2,
                            ),
                          );
                        },
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
