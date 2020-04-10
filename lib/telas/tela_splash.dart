import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/telas/tela_inicio.dart';

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
      Future.delayed(Duration(seconds: 3), () {
        if (user == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => TelaInicio(null, widget.atualizarConfigs),
            ),
          );
        } else {
          Usuario usuario = Usuario(user.uid, user.displayName, user.email);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => TelaInicio(usuario, widget.atualizarConfigs),
            ),
          );
        }
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
