import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/modelos/lista.dart';
import 'package:lista_compras/modelos/usuario.dart';

class FormLista extends StatefulWidget {
  final Usuario usuario;
  final Lista lista;

  FormLista({
    @required this.usuario,
    this.lista,
  });
  @override
  _FormListaState createState() => _FormListaState(
        TextEditingController(text: lista == null ? '' : lista.nome),
      );
}

class _FormListaState extends State<FormLista> {
  final TextEditingController nomeController;
  _FormListaState(
    this.nomeController,
  );

  _enviar() {
    String nome = nomeController.text;
    if (nome.isEmpty) {
      return;
    }
    if (this.widget.lista == null) {
      Firestore.instance.collection('listas').document().setData({
        'autor': this.widget.usuario.id,
        'nome': nome,
        'data': DateTime.now(),
      });
    } else {
      Firestore.instance
          .collection('listas')
          .document(this.widget.lista.id)
          .updateData({
        'nome': nome,
      });
    }
    Navigator.of(context).pop();
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
              this.widget.lista == null ? 'Adicionar Lista' : 'Editar Lista',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Nome da Lista',
              ),
              controller: nomeController,
              textCapitalization: TextCapitalization.sentences,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    this.widget.lista == null ? 'Enviar' : 'Salvar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: _enviar,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
