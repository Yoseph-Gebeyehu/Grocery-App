import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomstring_dart/randomstring_dart.dart';

import '../bloc/shopping_cart_bloc.dart';

class CheckOutWidget extends StatefulWidget {
  static const customerInfo = 'customer-info';
  String amount;
  String title;
  String description;
  CheckOutWidget({
    required this.amount,
    required this.title,
    required this.description,
  });

  @override
  _CheckOutWidgetState createState() => _CheckOutWidgetState();
}

class _CheckOutWidgetState extends State<CheckOutWidget> {
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
    return BlocListener<ShoppingCartBloc, ShoppingCartState>(
      listener: (context, state) {},
      child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
              child: Container(
                color: Colors.white,
                height: deviceSize.height * 0.3,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: deviceSize.width * 0.1,
                  right: deviceSize.width * 0.1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Order details',
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        rowText('Price of items', widget.amount),
                        SizedBox(height: deviceSize.height * 0.007),
                        rowText('Delivery fee', '0'),
                        SizedBox(height: deviceSize.height * 0.007),
                        rowText('Total fee', widget.amount),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        BlocProvider.of<ShoppingCartBloc>(context).add(
                          BuyEvent(
                            amount: widget.amount,
                            txRef: txRef,
                            currency: currency,
                            title: widget.title,
                            description: widget.description,
                          ),
                        );
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFEC54B)),
                        minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 50),
                        ),
                      ),
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: deviceSize.width * 0.05,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  rowText(String title, String amount) {
    Size deviceSize = MediaQuery.of(context).size;
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: deviceSize.width * 0.04,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        Text(
          '$amount br',
          style: TextStyle(
            fontSize: deviceSize.width * 0.04,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
