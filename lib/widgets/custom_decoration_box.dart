import 'package:flutter/material.dart';

class CustomDecorationBox extends StatelessWidget {
  final Color color;
  final IconData icon;
  final MainAxisAlignment align;
  const CustomDecorationBox({
    super.key,
    required this.color,
    required this.icon, required this.align,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: align ,
          children: [ 
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
