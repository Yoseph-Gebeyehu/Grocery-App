import 'package:flutter/material.dart';

class ThankYouPage extends StatelessWidget {
  static const thankyou = 'thank-you';
  const ThankYouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: deviceSize.height * 0.08,
        backgroundColor: const Color(0xFFFFFFFF),
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(left: deviceSize.width * 0.1),
          child: const Text(
            'Thank you',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/thank_you.png'),
            SizedBox(height: deviceSize.height * 0.1),
            Text(
              'Your Order in process',
              style: TextStyle(
                fontSize: deviceSize.width * 0.05,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: deviceSize.height * 0.02),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
              style: TextStyle(
                fontSize: deviceSize.width * 0.036,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: deviceSize.height * 0.1),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFFFEC54B)),
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 50),
                ),
              ),
              child: Text(
                'PLACE ORDER',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: deviceSize.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
