import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/Home/bloc/home_bloc.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_outlined,
              size: deviceSize.width * 0.2,
              color: Colors.red,
            ),
            Text(
              'Oops!',
              style: TextStyle(
                fontSize: deviceSize.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: deviceSize.width * 0.05,
                right: deviceSize.width * 0.05,
                top: 8,
              ),
              child: Text(
                'There is no Internet Connection.Please check your internet connection and try it again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: deviceSize.width * 0.04,
                  wordSpacing: 5,
                ),
              ),
            ),
            BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {},
              child: TextButton(
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(FetchProductsEvent());
                },
                child: Text(
                  'Refresh',
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.06,
                    color: const Color(0xFFE67F1E),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
