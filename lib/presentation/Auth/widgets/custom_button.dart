import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function function;
  String text;
  CustomButton({
    required this.function,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFFEC54B),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onPressed: () {
        function();
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: deviceSize.width * 0.04,
          color: Colors.white,
        ),
      ),
    );
  }
}
