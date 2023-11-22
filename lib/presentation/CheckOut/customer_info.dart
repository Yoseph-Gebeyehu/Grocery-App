import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/presentation/CheckOut/check_out.dart';
import 'package:http/http.dart' as http;

class CustomerInformationForm extends StatefulWidget {
  static const customerInfo = 'customer-info';
  @override
  _CustomerInformationFormState createState() =>
      _CustomerInformationFormState();
}

class _CustomerInformationFormState extends State<CustomerInformationForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? title;
  String? amount;
  String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: titleController,
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: amountController,
                onChanged: (value) {
                  setState(() {
                    amount = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: descriptionController,
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  var body = json.encode({
                    'email': 'yosephgebeyehu73@gmail.com',
                    'amount': amount,
                    'first_name': 'firstName',
                    'last_name': 'lastName',
                    'phone_number': '0918292773',
                    'tx_ref': 'hellbrohowyoudoing',
                    'currency': 'ETB',
                    'callback_url': 'https://your-callback-url.com',
                    'return_url': 'https://your-return-url.com',
                    'customization': {
                      'title': title,
                      'description': description,
                    }
                  });

                  var headers = {
                    'Authorization':
                        'Bearer CHASECK_TEST-KzqTmzYnjSL5UDnlA7YuiAZY3OoeujYo',
                    'Content-Type': 'application/json'
                  };
                  var response = await http.post(
                    Uri.parse('https://api.chapa.co/v1/transaction/initialize'),
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
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
