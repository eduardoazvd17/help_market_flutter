import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Validador {
  BuildContext context;
  Validador(this.context);

  _dialogo(String titulo, String conteudo) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(titulo),
          content: new Text(conteudo),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  mostrarCarregamento() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(),
                SizedBox(height: 15),
                new Text(
                  "Carregando",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ocultarCarregamento() {
    Navigator.of(context).pop();
  }

  bool valida(valor) {
    if (valor == null || valor.toString().isEmpty) {
      _dialogo(
        "Campos Vazios",
        "Para enviar, você deve preencher todos os campos necessários.",
      );
      return false;
    }
    return true;
  }

  bool validaSenhas(String senha, String confirmacao) {
    if (senha != confirmacao) {
      _dialogo(
        "Senhas Diferentes",
        "Os campos senha e confirmação de senha devem ser iguais.",
      );
      return false;
    }
    return true;
  }

  bool validaEmail(String email) {
    if (email.contains(RegExp('@.'))) {
      _dialogo(
        "E-mail Inválido",
        "O e-mail inserido é invalido, verifique a digitação e tente novamente.",
      );
      return false;
    }
    return true;
  }

  validaErro(String codigoErro) {
    switch (codigoErro) {
      case 'ERROR_INVALID_EMAIL':
        {
          _dialogo(
            "E-mail Inválido",
            "O e-mail inserido é invalido, verifique a digitação e tente novamente.",
          );
        }
        break;
      case 'ERROR_WRONG_PASSWORD':
        {
          _dialogo(
            "Senha Incorreta",
            "A senha não foi inserida corretamente.",
          );
        }
        break;
      case 'ERROR_USER_NOT_FOUND':
        {
          _dialogo(
            "Conta Inexistente",
            "Este e-mail não está cadastrado no nosso sistema. Efetue o cadastro para continuar.",
          );
        }
        break;
      case 'ERROR_WEAK_PASSWORD':
        {
          _dialogo(
            "Senha Fraca",
            "A senha deve conter 6 ou mais caracteres.",
          );
        }
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        {
          _dialogo(
            "Conta Existente",
            "Este e-mail ja está cadastrado no nosso sistema. Entre com sua conta para continuar.",
          );
        }
        break;
      default:
        {
          _dialogo(
            "Credenciais Incorretas",
            "Verifique sua digitação e tente novamente.",
          );
        }
    }
  }
}
