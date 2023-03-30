import 'package:flutter/material.dart';

class ProductButton extends StatelessWidget {
  final Color color;
  final String txt;
  final double size;
  final VoidCallback onPressed;

  ProductButton(@required this.color, @required this.txt, @required this.size,
      @required this.onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.txt,
        style: TextStyle(color: Colors.black),
      ),
      onPressed: this.onPressed,
      color: this.color,
      minWidth: this.size,
    );
  }
}
