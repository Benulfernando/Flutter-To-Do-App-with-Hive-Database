import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String name;
  VoidCallback on_pressed;
  Buttons({
    super.key,
    required this.name,
    required this.on_pressed
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(name),
      onPressed: on_pressed,
    );
  }
}
