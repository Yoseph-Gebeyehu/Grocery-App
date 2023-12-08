import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function function;
  String text;
  bool stateChecker;
  CustomButton({
    required this.function,
    required this.text,
    this.stateChecker = false,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: stateChecker,
            // visible: true,
            child: SizedBox(
              height: deviceSize.width * 0.04,
              width: deviceSize.width * 0.04,
              child: const CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: deviceSize.width * 0.04),
          Text(
            text,
            style: TextStyle(
              fontSize: deviceSize.width * 0.04,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
