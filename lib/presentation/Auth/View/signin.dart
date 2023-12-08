import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '/presentation/auth/view/signup.dart';
import '/presentation/auth/widgets/custom_button.dart';
import '/presentation/auth/widgets/form_field.dart';
import '/presentation/base-home-page/View/base_home.dart';
import '/presentation/Auth/bloc/auth_bloc.dart';
import '/widgets/snack_bar.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);
  static const signIn = 'signin';

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController emailController = TextEditingController();
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
                arguments: state.userName,
              );
            }
          },
          builder: (context, state) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 50,
              ),
              child: buildScreen(context),
            );
          },
        ),
      ),
    );
  }

  Widget buildScreen(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            width: deviceSize.width * 0.2,
            height: deviceSize.height * 0.15,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage(
                  'assets/ic_launcher.jpg',
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            'Sign in',
            style: TextStyle(
              color: Colors.black,
              fontSize: deviceSize.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: deviceSize.height * 0.03),
          text('Email'),
          SizedBox(height: deviceSize.height * 0.02),
          SizedBox(
            height: deviceSize.height * 0.06,
            child: CustomFormField(
              controller: emailController,
              hintText: 'email',
            ),
          ),
          SizedBox(height: deviceSize.height * 0.02),
          text('Password'),
          SizedBox(height: deviceSize.height * 0.02),
          SizedBox(
            height: deviceSize.height * 0.06,
            child: CustomFormField(
              controller: passwordController,
              obscure: obscure,
              hintText: 'Password',
              function: () {
                setState(() {
                  setState(() {
                    obscure = !obscure;
                  });
                });
              },
            ),
          ),
          Row(
            children: [
              const SizedBox(),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: const Color(0xFFFEC54B),
                    fontSize: deviceSize.width * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: deviceSize.height * 0.01),
          Container(
            height: deviceSize.height * 0.06,
            width: deviceSize.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return CustomButton(
                  stateChecker: state is AuthLoadingState,
                  function: () {
                    context.read<AuthBloc>().add(
                          LoginEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                  },
                  text: 'Sign in',
                );
              },
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
                FontAwesome.facebook,
                color: Colors.blue,
              ),
              Icon(
                FontAwesome.twitter,
                color: Colors.blue,
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
                onPressed: () {
                  Navigator.pushNamed(context, SignUpPage.signUp);
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.04,
                    color: const Color(0xFFFEC54B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  text(String text) {
    Size deviceSize = MediaQuery.of(context).size;
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: deviceSize.width * 0.04,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
