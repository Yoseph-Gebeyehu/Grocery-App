import 'package:flutter/material.dart';

import '/widgets/snack_bar.dart';
import '/data/models/user.dart';
import '/data/service.dart';
import '../widgets/form_field.dart';
import '../../Auth/View/signin.dart';
import '../../Auth/widgets/custom_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const signUp = 'signUp';

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool obscure = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: deviceSize.height * 0.05,
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: buildScreen(context),
        ),
      ),
    );
  }

  Widget buildScreen(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontSize: deviceSize.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: deviceSize.height * 0.03),
          text('User name'),
          SizedBox(height: deviceSize.height * 0.02),
          SizedBox(
            height: deviceSize.height * 0.06,
            child: CustomFormField(
              keyboardType: TextInputType.name,
              controller: userNameController,
              hintText: 'user name',
            ),
          ),
          SizedBox(height: deviceSize.height * 0.02),
          text('Email'),
          SizedBox(height: deviceSize.height * 0.02),
          SizedBox(
            height: deviceSize.height * 0.06,
            child: CustomFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              hintText: 'email',
            ),
          ),
          SizedBox(height: deviceSize.height * 0.02),
          text('Password'),
          SizedBox(height: deviceSize.height * 0.02),
          passwordForm(passwordController),
          SizedBox(height: deviceSize.height * 0.02),
          text('Confirm password'),
          SizedBox(height: deviceSize.height * 0.02),
          passwordForm(confirmPasswordController),
          SizedBox(height: deviceSize.height * 0.05),
          Container(
            height: deviceSize.height * 0.06,
            width: deviceSize.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: CustomButton(
              function: onSignup,
              text: 'Sign up',
            ),
          ),
          SizedBox(height: deviceSize.height * 0.02),
        ],
      ),
    );
  }

  SizedBox passwordForm(TextEditingController controller) {
    Size deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      height: deviceSize.height * 0.06,
      child: CustomFormField(
        keyboardType: TextInputType.visiblePassword,
        controller: controller,
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
    );
  }

  Future<void> onSignup() async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text &&
          userNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          emailController.text.contains('@gmail.com') &&
          passwordController.text.isNotEmpty &&
          passwordController.text.length >= 6) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        Map<String, String> userMap = {
          'userName': userNameController.text,
          'email': emailController.text,
          'password': passwordController.text,
        };
        User user = User.fromJson(userMap);
        await UserServies().addUserToDB(user);
        await Future.delayed(const Duration(seconds: 2));

        Navigator.pop(context);

        Navigator.pushNamed(context, SigninPage.signIn);
      } else {
        if (emailController.text.contains('@gmail.com') &&
            passwordController.text != confirmPasswordController.text) {
          SnackBarWidget().showSnack(context, 'Please confirm your password.');
        } else if (!emailController.text.contains('@gmail.com') &&
            passwordController.text == confirmPasswordController.text) {
          SnackBarWidget().showSnack(context, "Email must contain @gmail.com");
        } else if (passwordController.text.length < 6) {
          SnackBarWidget().showSnack(
              context, "The password should be at least 6 characters long.");
        }
      }
    }
  }

  Text text(String text) {
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
