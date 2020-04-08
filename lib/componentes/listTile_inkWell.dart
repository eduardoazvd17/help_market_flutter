import 'package:flutter/material.dart';

class ListTileInkWell extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function function;

  ListTileInkWell({
    @required this.text,
    @required this.function,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: ListTile(
        leading: icon,
        title: Text(text),
      ),
    );
  }
}
