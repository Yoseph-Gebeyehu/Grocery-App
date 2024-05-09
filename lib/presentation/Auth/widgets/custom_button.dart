import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function function;
  final String text;
  final bool stateChecker;
  const CustomButton({
    super.key,
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
          Theme.of(context).primaryColor,
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
              fontSize: deviceSize.width * 0.036,
              color: Theme.of(context).textTheme.labelLarge!.color,
            ),
          ),
        ],
      ),
    );
  }
}
