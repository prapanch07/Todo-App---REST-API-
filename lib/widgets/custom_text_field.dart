import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hinttext;
  final int minLine;
  final int maxLine;

  const CustomTextField({
    super.key,
    required TextEditingController titlecontroller,
    required this.hinttext,
    required this.minLine,
    required this.maxLine,
  }) : _titlecontroller = titlecontroller;

  final TextEditingController _titlecontroller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _titlecontroller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hinttext,
      ),
      minLines: minLine,
      maxLines: maxLine,
    );
  }
}
