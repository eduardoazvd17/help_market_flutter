import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_compras/componentes/botao_ajustes.dart';
import 'package:lista_compras/componentes/form_ajustes_conta.dart';
import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/utilitarios/validador.dart';

class TelaAjustesConta extends StatefulWidget {
  final Usuario usuario;
  final Function(Usuario) atualizarUsuario;
  TelaAjustesConta(this.usuario, this.atualizarUsuario);

  @override
  _TelaAjustesContaState createState() => _TelaAjustesContaState();
}

class _TelaAjustesContaState extends State<TelaAjustesConta> {
  String fotoUrl;

  _abrirModal(context, int opcao) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => FormAjustesConta(
        usuario: widget.usuario,
        atualizarUsuario: widget.atualizarUsuario,
        opcao: opcao,
      ),
    );
  }

  Future _getFoto(context, opc) async {
    var foto;
    try {
      if (opc) {
        foto = await ImagePicker.pickImage(source: ImageSource.camera);
      } else {
        foto = await ImagePicker.pickImage(source: ImageSource.gallery);
      }
    } catch (e) {
      Validador(context)
          .mostrarAviso("Você precisa permitir antes de utilizar esta função.");
    }

    if (foto == null) {
      return;
    }

    _uploadFoto(context, foto);
  }

  Future _uploadFoto(context, foto) async {
    var validador = Validador(context);
    validador.mostrarCarregamento();
    try {
      var storageReference =
          FirebaseStorage().ref().child("/fotosPerfil/" + widget.usuario.id);
      var uploadTask = storageReference.putFile(foto);
      await uploadTask.onComplete;
      var usuario = await FirebaseAuth.instance.currentUser();
      var update = UserUpdateInfo();
      update.photoUrl = await storageReference.getDownloadURL();
      usuario.updateProfile(update);
      setState(() {
        fotoUrl = update.photoUrl;
      });
      validador.ocultarCarregamento();
      Validador(context).mostrarAviso("Sua foto de perfil foi alterada.");
      widget.usuario.fotoUrl = update.photoUrl;
      widget.atualizarUsuario(widget.usuario);
    } catch (e) {
      validador.ocultarCarregamento();
      validador.mostrarAviso(
          "Não foi possivel enviar a foto. Tente nvoamente mais tarde.");
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        fotoUrl = user.photoUrl;
      });
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.usuario.nome),
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
                                    child: fotoUrl == null
                                        ? Container(
                                            width: largura * 0.4,
                                            height: largura * 0.4,
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Icon(Icons.person,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                size: largura * 0.3),
                                          )
                                        : Image.network(
                                            fotoUrl,
                                            width: largura * 0.4,
                                            height: largura * 0.4,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          Icons.camera_alt,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                        onPressed: () =>
                                            _getFoto(context, true),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.image,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                        onPressed: () =>
                                            _getFoto(context, false),
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
                        icone: Icons.person,
                        funcao: () => _abrirModal(context, 0),
                      ),
                      BotaoAjustes(
                        titulo: "Alterar E-mail",
                        icone: Icons.mail,
                        funcao: () => _abrirModal(context, 1),
                      ),
                      BotaoAjustes(
                        titulo: "Alterar Senha",
                        icone: Icons.lock,
                        funcao: () => _abrirModal(context, 2),
                      ),
                      SizedBox(height: 20),
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
