import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/telas/tela_navegacao.dart';

class TelaSplash extends StatefulWidget {
  final Function atualizarConfigs;
  TelaSplash(this.atualizarConfigs);
  @override
  _TelaSplashState createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      Usuario usuario;
      if (user != null) {
        usuario = Usuario(user.uid, user.displayName, user.email,
            fotoUrl: user.photoUrl == null ? null : user.photoUrl);
        widget.atualizarConfigs(usuario);
      }
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TelaNavegacao(usuario, widget.atualizarConfigs),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Container(
            height: altura * 0.4,
            width: altura * 0.4,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(altura),
            ),
            child: Padding(
              padding: EdgeInsets.all(50),
              child: Image.asset(
                'assets/img/login-img.png',
                height: altura * 0.25,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
