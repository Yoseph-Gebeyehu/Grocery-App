import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          toolbarHeight: deviceSize.height * 0.05,
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).iconTheme.color),
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
            AppLocalizations.of(context)!.sign_up,
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge!.color,
              fontSize: deviceSize.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: deviceSize.height * 0.03),
          text(AppLocalizations.of(context)!.user_name),
          SizedBox(height: deviceSize.height * 0.02),
          SizedBox(
            height: deviceSize.height * 0.06,
            child: CustomFormField(
              keyboardType: TextInputType.name,
              controller: userNameController,
              hintText: AppLocalizations.of(context)!.user_name,
            ),
          ),
          SizedBox(height: deviceSize.height * 0.02),
          text(AppLocalizations.of(context)!.email),
          SizedBox(height: deviceSize.height * 0.02),
          SizedBox(
            height: deviceSize.height * 0.06,
            child: CustomFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              hintText: AppLocalizations.of(context)!.email,
            ),
          ),
          SizedBox(height: deviceSize.height * 0.02),
          text(AppLocalizations.of(context)!.password),
          SizedBox(height: deviceSize.height * 0.02),
          passwordForm(passwordController),
          SizedBox(height: deviceSize.height * 0.02),
          text(AppLocalizations.of(context)!.confirm_password),
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
              text: AppLocalizations.of(context)!.sign_up,
            ),
          ),
          SizedBox(height: deviceSize.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.already_have_an_account,
                style: TextStyle(
                  fontSize: deviceSize.width * 0.036,
                  color: Theme.of(context).textTheme.titleLarge!.color,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.sign_in,
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.04,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
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
          SnackBarWidget().showSnack(context,
              AppLocalizations.of(context)!.please_confirm_your_password);
        } else if (!emailController.text.contains('@gmail.com') &&
            passwordController.text == confirmPasswordController.text) {
          SnackBarWidget().showSnack(
              context, AppLocalizations.of(context)!.email_must_contain);
        } else if (passwordController.text.length < 6) {
          SnackBarWidget().showSnack(
              context,
              AppLocalizations.of(context)!
                  .the_password_should_be_at_least_6_characters_long);
        }
      }
    }
  }

  Text text(String text) {
    Size deviceSize = MediaQuery.of(context).size;
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).textTheme.titleLarge!.color,
        fontSize: deviceSize.width * 0.04,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
