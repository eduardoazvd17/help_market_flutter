import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/botao_form_login.dart';
import 'package:lista_compras/componentes/input_form_login.dart';
import 'package:flutter/services.dart';

import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/utilitarios/validador.dart';

class FormAjustesConta extends StatefulWidget {
  final Usuario usuario;
  final Function(Usuario) atualizarUsuario;
  final int opcao;

  FormAjustesConta({
    @required this.usuario,
    @required this.atualizarUsuario,
    @required this.opcao,
  });

  @override
  _FormAjustesContaState createState() => opcao == 0
      ? _FormAjustesContaState(
          dadosController: TextEditingController(text: usuario.nome),
        )
      : _FormAjustesContaState(
          dadosController: TextEditingController(),
          confirmacaoDadosController: TextEditingController(),
        );
}

class _FormAjustesContaState extends State<FormAjustesConta> {
  final TextEditingController dadosController;
  final TextEditingController confirmacaoDadosController;
  _FormAjustesContaState(
      {this.dadosController, this.confirmacaoDadosController});
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
      'hint': 'Novo E-mail',
      'hintConfirmacao': 'Confirmação de E-mail',
      'icone': Icons.mail,
      'teclado': TextInputType.emailAddress,
      'captalizacao': TextCapitalization.none,
      'ocultar': false,
    },
    {
      'titulo': 'Alterar Senha',
      'subtitulo': 'Para alterar sua senha preencha o formulário abaixo:',
      'hint': 'Nova Senha',
      'hintConfirmacao': 'Confirmação de Senha',
      'icone': Icons.lock,
      'teclado': TextInputType.text,
      'captalizacao': TextCapitalization.none,
      'ocultar': true,
    },
  ];

  _salvar(context) async {
    var user = await FirebaseAuth.instance.currentUser();
    var validador =
        Validador(context, atualizarUsuario: widget.atualizarUsuario);
    switch (widget.opcao) {
      case 0:
        {
          String nome = dadosController.text;

          if (!validador.valida(nome)) {
            return;
          }

          validador.mostrarCarregamento();

          try {
            var update = UserUpdateInfo();
            update.displayName = nome;
            await user.updateProfile(update);
            validador.ocultarCarregamento();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            widget.atualizarUsuario(Usuario(user.uid, nome, user.email));
            validador.mostrarAviso("Seu nome foi alterado com sucesso!");
          } catch (e) {
            validador.validaErro(e.code);
          }
        }
        break;
      case 1:
        {
          String email = dadosController.text.trim();
          String confirmacaoEmail = confirmacaoDadosController.text.trim();

          if (!validador.valida(email) ||
              !validador.valida(confirmacaoEmail) ||
              !validador.validaEmail(email) ||
              !validador.validaEmail(confirmacaoEmail) ||
              !validador.validaEmails(email, confirmacaoEmail)) {
            return;
          }

          validador.mostrarCarregamento();

          try {
            await user.updateEmail(email);
            validador.ocultarCarregamento();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            widget.atualizarUsuario(Usuario(user.uid, user.displayName, email));
            validador.mostrarAviso("Seu e-mail foi alterado com sucesso!");
          } catch (e) {
            validador.ocultarCarregamento();
            validador.validaErro(e.code);
          }
        }
        break;
      case 2:
        {
          String senha = dadosController.text.trim();
          String confirmacaoSenha = confirmacaoDadosController.text.trim();

          if (!validador.valida(senha) ||
              !validador.valida(confirmacaoSenha) ||
              !validador.validaSenhas(senha, confirmacaoSenha)) {
            return;
          }

          validador.mostrarCarregamento();

          try {
            await user.updatePassword(senha);
            validador.ocultarCarregamento();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            validador.mostrarAviso("Sua senha foi alterada com sucesso!");
          } catch (e) {
            validador.ocultarCarregamento();
            validador.validaErro(e.code);
          }
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
              conteudo[widget.opcao]['titulo'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                  '${widget.opcao == 1 ? 'Seu e-mail atual é: ' + widget.usuario.email + '\n' : ''}${conteudo[widget.opcao]['subtitulo']}'),
            ),
            InputFormLogin(
              ocultar: conteudo[widget.opcao]['ocultar'],
              controller: dadosController,
              icone: conteudo[widget.opcao]['icone'],
              hint: conteudo[widget.opcao]['hint'],
              teclado: conteudo[widget.opcao]['teclado'],
              captalizacao: conteudo[widget.opcao]['captalizacao'],
            ),
            !(conteudo[widget.opcao]['hintConfirmacao'] == null)
                ? Column(
                    children: <Widget>[
                      InputFormLogin(
                        ocultar: conteudo[widget.opcao]['ocultar'],
                        controller: confirmacaoDadosController,
                        icone: conteudo[widget.opcao]['icone'],
                        hint: conteudo[widget.opcao]['hintConfirmacao'],
                        teclado: conteudo[widget.opcao]['teclado'],
                        captalizacao: conteudo[widget.opcao]['captalizacao'],
                      ),
                    ],
                  )
                : Container(),
            SizedBox(height: 16),
            BotaoFormLogin(
              funcao: () => _salvar(context),
              titulo: 'Salvar',
            )
          ],
        ),
      ),
    );
  }
}
