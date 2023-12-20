import 'package:flutter/material.dart';

class SnackBarWidget {
  showSnack(BuildContext context, String title) {
    Size deviceSize = MediaQuery.of(context).size;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceSize.height * 0.025,
              child: Image.asset('assets/splash.png'),
            ),
            SizedBox(width: deviceSize.width * 0.05),
            Text(
              title,
              style: TextStyle(fontSize: deviceSize.width * 0.03),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 1000),
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200),
        ),
      ),
    );
  }
}
