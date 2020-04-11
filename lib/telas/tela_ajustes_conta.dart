import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/ajustes_btn.dart';
import 'package:lista_compras/componentes/form_modificar_ajustes.dart';
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
                        texto: "Modificar Nome",
                        icone: Icons.person,
                        funcao: () {
                          print("teste");
                          alterarDados(
                            false,
                            context,
                            "Modificar nome",
                            "Se deseja modificar seu nome digite-o abaixo:",
                            "Nome",
                            "Modificar nome",
                            Icons.person,
                          );
                        },
                      ),
                      AjustesBtn(
                        texto: "Modificar Senha",
                        icone: Icons.lock,
                        funcao: () {
                          print("teste");
                          alterarDados(
                            true,
                            context,
                            "Modificar Senha",
                            "Se deseja modificar seu Senha digite-o abaixo:",
                            "Senha",
                            "Modificar Senha",
                            Icons.lock,
                            "Confirmar Senha",
                            true,
                          );
                        },
                      ),
                      AjustesBtn(
                        texto: "Modificar Email",
                        icone: Icons.mail,
                        funcao: () {
                          print("teste");
                          alterarDados(
                            true,
                            context,
                            "Modificar Email",
                            "Se deseja modificar seu email digite-o abaixo:",
                            "Email",
                            "Modificar Email",
                            Icons.mail,
                            "Confirmar email",
                            true,
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

  alterarDados(
    ok,
    context,
    titulo,
    corpo,
    hintCampoTexto,
    textoBtn,
    icone, [
    hintCampoTexto2 = "",
    dif = false,
  ]) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => FormModificarAjustes(
        titulo: titulo,
        hintCampoTexto2: hintCampoTexto2,
        dif: dif,
        corpo: corpo,
        hintCampoTexto: hintCampoTexto,
        textoBtn: textoBtn,
        icone: icone,
        dadosController: dadosController,
        confirmacaoDadosController: ok ? confirmacaoDadosController : null,
      ),
    );
  }
}
