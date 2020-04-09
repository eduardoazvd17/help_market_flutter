import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/modelos/lista.dart';
import 'package:lista_compras/modelos/produto.dart';
import 'package:lista_compras/modelos/usuario.dart';

class FormProduto extends StatefulWidget {
  final Usuario usuario;
  final Lista lista;
  final Produto produto;

  FormProduto({
    @required this.usuario,
    @required this.lista,
    @required this.produto,
  });
  @override
  _FormProdutoState createState() => _FormProdutoState(
      TextEditingController(text: produto == null ? '' : produto.nome),
      produto == null ? 1 : produto.quantidade);
}

class _FormProdutoState extends State<FormProduto> {
  TextEditingController nomeController;
  int quantidade;
  _FormProdutoState(this.nomeController, this.quantidade);

  _enviar() {
    String nome = nomeController.text;
    if (this.widget.produto == null) {
      if (nome.isEmpty) {
        return;
      }
      Firestore.instance
          .collection('listas')
          .document(widget.lista.id)
          .collection('produtos')
          .document()
          .setData({
        'nome': nome,
        'quantidade': quantidade,
      });
    } else {
      if (nome.isEmpty) {
        return;
      }
      Firestore.instance
          .collection('listas')
          .document(widget.lista.id)
          .collection('produtos')
          .document(widget.produto.id)
          .updateData({
        'nome': nome,
        'quantidade': quantidade,
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
              this.widget.produto == null
                  ? 'Adicionar Produto'
                  : 'Editar Produto',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Nome do Produto',
              ),
              controller: nomeController,
              textCapitalization: TextCapitalization.sentences,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Quantidade:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (quantidade >= 99) {
                        return;
                      }
                      quantidade++;
                    });
                  },
                ),
                Text(
                  quantidade.toString(),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantidade <= 1) {
                        return;
                      }
                      quantidade--;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    this.widget.produto == null ? 'Enviar' : 'Salvar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
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
