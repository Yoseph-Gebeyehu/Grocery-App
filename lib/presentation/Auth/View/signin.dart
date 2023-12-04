import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../widgets/snack_bar.dart';
import '../../../presentation/Auth/bloc/auth_bloc.dart';
import '../../../presentation/base-home-page/View/base_home.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);
  static const signIn = 'signin';

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthErrorState) {
              SnackBarWidget().showSnack(context, 'Invalid username/password');
            } else if (state is AuthLoadedState) {
              await Navigator.pushNamed(
                context,
                BaseHomePage.baseHomePage,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return Stack(
                children: [
                  buildScreen(context),
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.grey.withOpacity(0.55),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(width: 10),
                          Text("Loading..."),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return buildScreen(context);
          },
        ),
      ),
    );
  }

  Widget buildScreen(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: deviceSize.width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.02),
                  Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: deviceSize.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.02),
                  SizedBox(
                    height: deviceSize.height * 0.06,
                    child: TextFormField(
                      controller: userNameController,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: const Color(0xFFFEC54B),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 180, 174, 174),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 239, 228, 203),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.02),
                  Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: deviceSize.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.02),
                  SizedBox(
                    height: deviceSize.height * 0.06,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: obscure,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: const Color(0xFFFEC54B),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 239, 228, 203),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscure ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.02),
                  Row(
                    children: [
                      const SizedBox(),
                      const Spacer(),
                      Text('Forgot Password?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: deviceSize.width * 0.035,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  SizedBox(height: deviceSize.height * 0.03),
                  Container(
                    height: deviceSize.height * 0.06,
                    width: deviceSize.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFFEC54B),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              LoginEvent(
                                username: userNameController.text,
                                password: passwordController.text,
                              ),
                            );
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: deviceSize.width * 0.04,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: deviceSize.width * 0.25,
                        child: const Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 182, 174, 174),
                        ),
                      ),
                      const Text('Or Login with'),
                      SizedBox(
                        width: deviceSize.width * 0.25,
                        child: const Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 182, 174, 174),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: deviceSize.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      ),
                      Icon(
                        Icons.apple,
                      ),
                      Icon(
                        FontAwesome.google,
                        color: Color(0xFF4285F4),
                      ),
                    ],
                  ),
                  SizedBox(height: deviceSize.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontSize: deviceSize.width * 0.036,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: deviceSize.width * 0.036,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
