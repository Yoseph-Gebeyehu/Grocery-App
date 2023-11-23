import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:randomstring_dart/randomstring_dart.dart';
import 'package:http/http.dart' as http;

import '../../../domain/constants/images/chapa_images.dart';
import '../../check-out/check_out.dart';

class CheckOutWidget extends StatefulWidget {
  static const customerInfo = 'customer-info';
  String amount;
  CheckOutWidget({required this.amount});

  @override
  _CheckOutWidgetState createState() => _CheckOutWidgetState();
}

class _CheckOutWidgetState extends State<CheckOutWidget> {
  String? title;
  String? description;
  String currency = 'ETB';
  String key = 'CHASECK_TEST-KzqTmzYnjSL5UDnlA7YuiAZY3OoeujYo';

  var rs = RandomString();

  var txRef = RandomString().getRandomString(
    uppersCount: 10,
    lowersCount: 10,
    specialsCount: 2,
  );

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          color: Colors.white,
          height: deviceSize.height * 0.3,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: deviceSize.width * 0.05,
            right: deviceSize.width * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Complete action via',
                style: TextStyle(
                  fontSize: deviceSize.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: Text(
                  'Chapa Financial Technologies',
                  style: TextStyle(fontSize: deviceSize.width * 0.04),
                  textAlign: TextAlign.center,
                ),
                trailing: Container(
                  width: deviceSize.width * 0.2,
                  child: Image.asset(
                    ChapaImage.chapa,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      var body = json.encode({
                        'email': 'yosephgebeyehu73@gmail.com',
                        'amount': widget.amount,
                        'first_name': 'firstName',
                        'last_name': 'lastName',
                        'phone_number': '0918292773',
                        'tx_ref': txRef,
                        'currency': currency,
                        'callback_url': 'https://your-callback-url.com',
                        'return_url': 'https://your-return-url.com',
                        'customization': {
                          'title': title,
                          'description': description,
                        }
                      });

                      var headers = {
                        'Authorization': 'Bearer $key',
                        'Content-Type': 'application/json'
                      };
                      var response = await http.post(
                        Uri.parse(
                            'https://api.chapa.co/v1/transaction/initialize'),
                        headers: headers,
                        body: body,
                      );
                      print(response.statusCode);
                      var responseData = json.decode(response.body);

                      String checkoutUrl = responseData['data']['checkout_url'];
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ChapaCheckoutScreen(checkOutUrl: checkoutUrl)));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFFEC54B)),
                      minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 50),
                      ),
                    ),
                    child: const Text(
                      'Buy',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
