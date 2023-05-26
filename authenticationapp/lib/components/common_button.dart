import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String? buttonLabel;
  final VoidCallback? apiFunction;
  // ignore: prefer_const_constructors_in_immutables
  CommonButton({Key? key, this.buttonLabel, this.apiFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Set the border radius
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: apiFunction,
      child: Text(buttonLabel!),
    );
  }
}
