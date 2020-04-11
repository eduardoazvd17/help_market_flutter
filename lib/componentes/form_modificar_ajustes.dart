import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/btnLogin_form.dart';
import 'package:lista_compras/componentes/inputLogin_form.dart';

class FormModificarAjustes extends StatelessWidget {
  final String titulo;
  final String corpo;
  final String hintCampoTexto;
  final String hintCampoTexto2;
  final String textoBtn;
  final bool dif;
  final IconData icone;
  TextEditingController dadosController;
  TextEditingController confirmacaoDadosController;

  FormModificarAjustes({
    @required this.titulo,
    @required this.corpo,
    @required this.hintCampoTexto,
    this.hintCampoTexto2,
    @required this.textoBtn,
    this.dif = false,
    this.icone,
    this.dadosController,
    this.confirmacaoDadosController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$titulo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('$corpo'),
            ),
            InputLoginForm(
              controller: dadosController,
              icon: icone,
              hintText: '$hintCampoTexto',
              keyboardType: TextInputType.emailAddress,
            ),
            dif
                ? InputLoginForm(
                    controller: confirmacaoDadosController,
                    icon: icone,
                    hintText: '$hintCampoTexto2',
                    keyboardType: TextInputType.emailAddress,
                  )
                : Center(),
            SizedBox(height: 10),
            BtnLoginForm(
              funcao: () {
                dadosController.clear();
                confirmacaoDadosController.clear();
              },
              cor: Theme.of(context).accentColor,
              texto: '$textoBtn',
            )
          ],
        ),
      ),
    );
  }
}
