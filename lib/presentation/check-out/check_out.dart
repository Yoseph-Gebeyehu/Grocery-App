import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChapaCheckoutScreen extends StatelessWidget {
  String checkOutUrl;
  ChapaCheckoutScreen({
    required this.checkOutUrl,
  });
  // final String checkoutUrl =
  // 'https://checkout.chapa.co/checkout/payment/ZZDPCEUBJURRiItL592NkVB2WBz8UkvGLXAwzwdbs44Cy';

  // void navigateToCheckout() async {
  //   if (await canLaunch(checkoutUrl)) {
  //     await launch(checkoutUrl);
  //   } else {
  //     throw 'Could not launch $checkoutUrl';
  //   }
  // }

  //  final Uri  _uri = Uri.parse(checkOutUrl);
  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(checkOutUrl))) {
      throw Exception('counld not launch ${Uri.parse(checkOutUrl)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapa Checkout'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _launchUrl(),
          child: const Text('Go to Checkout'),
        ),
      ),
    );
  }
}
