import 'package:flutter/material.dart';

class CustomTextFiled extends StatefulWidget {
  final Icon icon;
  final String hintText;
  final String labelInit;
  final dynamic onChanged;
  final bool obscureText;
  CustomTextFiled(
      {Key? key,
      required this.hintText,
      required this.icon,
      this.labelInit = '',
      required this.onChanged,
      this.obscureText = false})
      : super(key: key);

  @override
  _CustomTextFiledState createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  TextEditingController txt = TextEditingController();

  @override
  void initState() {
    txt.text = widget.labelInit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: txt,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.white24),
        prefixIcon: widget.icon,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      obscureText: widget.obscureText,
      style: const TextStyle(color: Colors.white),
      onChanged: (value) {
        widget.onChanged(value);
      },
    );
  }
}
