import 'package:flutter/material.dart';

class PinkButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;
  const PinkButton(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        width: MediaQuery.of(context).size.width * width,
        decoration: BoxDecoration(
            color: Colors.red.shade500,
            borderRadius: BorderRadius.circular(12)),
        child: MaterialButton(
            onPressed: onPressed,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
            )));
  }
}
