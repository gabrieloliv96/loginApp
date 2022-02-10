// ignore_for_file: prefer_final_fields

import 'package:escolamobile/controllers/login_controller.dart';
import 'package:flutter/material.dart';

class TextFormLoginWidget extends StatefulWidget {
  final String label;
  final bool? isObscure;
  final Icon icon;
  final TextInputType textInput;
  final Color cor;
  final bool? showButtom;
  final TextEditingController? controller;
  final Function(String)? onChangeController;

  const TextFormLoginWidget({
    Key? key,
    required this.label,
    this.isObscure,
    required this.icon,
    required this.textInput,
    required this.cor,
    this.showButtom,
    this.controller,
    this.onChangeController,
  }) : super(key: key);

  @override
  State<TextFormLoginWidget> createState() => _TextFormLoginWidgetState();
}

class _TextFormLoginWidgetState extends State<TextFormLoginWidget> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(color: widget.cor),
      cursorColor: widget.cor,
      keyboardType: widget.textInput,
      decoration: InputDecoration(
        hoverColor: widget.cor,
        labelText: widget.label,
        labelStyle: TextStyle(color: widget.cor),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          borderSide: BorderSide(color: widget.cor),
        ),
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: widget.icon,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(color: widget.cor),
        ),
        suffixIcon: (widget.showButtom == null)
            ? null
            : IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: _toggle,
              ),
      ),
      obscureText: (widget.isObscure == null) ? false : _obscureText,
      onChanged: widget.onChangeController,
      // onChanged: ,
    );
  }
}
