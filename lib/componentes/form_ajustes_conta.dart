import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/btnLogin_form.dart';
import 'package:lista_compras/componentes/inputLogin_form.dart';
import 'package:lista_compras/modelos/usuario.dart';

class FormAjustesConta extends StatelessWidget {
  final Usuario usuario;
  final int opcao;
  final dadosController = TextEditingController();
  final confirmacaoDadosController = TextEditingController();
  final List<Map<String, dynamic>> conteudo = [
    {
      'titulo': 'Alterar Nome',
      'subtitulo': 'Para alterar seu nome preencha o formulário abaixo:',
      'hint': 'Nome',
      'icone': Icons.person,
      'teclado': TextInputType.text,
      'captalizacao': TextCapitalization.words,
      'ocultar': false,
    },
    {
      'titulo': 'Alterar E-mail',
      'subtitulo': 'Para alterar seu e-mail preencha o formulário abaixo:',
      'hint': 'E-mail',
      'hintConfirmacao': 'Confirmar E-mail',
      'icone': Icons.person,
      'teclado': TextInputType.emailAddress,
      'captalizacao': TextCapitalization.none,
      'ocultar': false,
    },
    {
      'titulo': 'Alterar Senha',
      'subtitulo': 'Para alterar sua senha preencha o formulário abaixo:',
      'hint': 'Senha',
      'hintConfirmacao': 'Confirmar Senha',
      'icone': Icons.person,
      'teclado': TextInputType.text,
      'captalizacao': TextCapitalization.none,
      'ocultar': true,
    },
  ];

  FormAjustesConta({
    @required this.usuario,
    @required this.opcao,
  });

  _salvar(context) {
    switch (opcao) {
      case 0:
        {
          String nome = dadosController.text;
        }
        break;
      case 1:
        {
          String email = dadosController.text.trim();
          String confirmacaoDadosController = dadosController.text.trim();
        }
        break;
      case 2:
        {
          String senha = dadosController.text.trim();
          String confirmacaoSenha = confirmacaoDadosController.text.trim();
        }
        break;
      default:
        return;
    }
  }

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
              conteudo[opcao]['titulo'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(conteudo[opcao]['subtitulo']),
            ),
            InputLoginForm(
              obscureText: conteudo[opcao]['ocultar'],
              controller: dadosController,
              icon: conteudo[opcao]['icone'],
              hintText: conteudo[opcao]['hint'],
              keyboardType: conteudo[opcao]['teclado'],
              captalizacao: conteudo[opcao]['captalizacao'],
            ),
            !(conteudo[opcao]['hintConfirmacao'] == null)
                ? Column(
                    children: <Widget>[
                      InputLoginForm(
                        obscureText: conteudo[opcao]['ocultar'],
                        controller: confirmacaoDadosController,
                        icon: conteudo[opcao]['icone'],
                        hintText: conteudo[opcao]['hintConfirmacao'],
                        keyboardType: conteudo[opcao]['teclado'],
                        captalizacao: conteudo[opcao]['captalizacao'],
                      ),
                    ],
                  )
                : Container(),
            SizedBox(height: 16),
            BtnLoginForm(
              funcao: () {
                dadosController.clear();
                confirmacaoDadosController.clear();
              },
              texto: 'Salvar',
            )
          ],
        ),
      ),
    );
  }
}
