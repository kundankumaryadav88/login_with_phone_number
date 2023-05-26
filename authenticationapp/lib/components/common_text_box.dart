import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextBox extends StatelessWidget {
  final TextEditingController? controllerValue;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormate;
  const CommonTextBox(
      {Key? key, this.controllerValue, this.decoration, this.inputFormate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerValue,
      decoration: decoration,
      inputFormatters: inputFormate,
    );
  }
}
