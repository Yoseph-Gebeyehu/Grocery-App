import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:grocery/data/local/shered_preference.dart';
import 'package:grocery/main.dart';

import '/presentation/auth/widgets/custom_button.dart';
import '/presentation/auth/widgets/form_field.dart';
import '/presentation/auth/view/signup.dart';
import '/presentation/Auth/bloc/auth_bloc.dart';
import '/presentation/base-home-page/View/base_home.dart';
import '/widgets/snack_bar.dart';

enum SampleItem { am, en }

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);
  static const signIn = 'signin';

  @override
  SigninPageState createState() => SigninPageState();
}

class SigninPageState extends State<SigninPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscure = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Form(
          key: formKey,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) async {
                if (state is AuthErrorState) {
                  SnackBarWidget().showSnack(
                      context,
                      AppLocalizations.of(context)!
                          .invalid_username_or_password);
                } else if (state is AuthLoadedState) {
                  await Navigator.pushNamed(context, BaseHomePage.baseHomePage,
                      arguments: state.user);
                }
              },
              builder: (context, state) {
                return Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 50,
                  ),
                  child: buildScreen(context),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildScreen(BuildContext context) {
    SampleItem? selectedMenu;
    String lang = 'en';
    Size deviceSize = MediaQuery.of(context).size;
    return ListView(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.language,
                color: Theme.of(context).primaryColor,
              ),
              PopupMenuButton<SampleItem>(
                color: Theme.of(context).scaffoldBackgroundColor,
                iconColor: Theme.of(context).primaryColor,
                initialValue: selectedMenu,
                onSelected: (SampleItem item) {
                  setState(() {
                    selectedMenu = item;
                    String lang = item == SampleItem.am ? 'am' : 'en';
                    LocalStorage.setLanguage('language', lang);
                  });
                  MyApp.setLanguage(context);
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<SampleItem>>[
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.am,
                    child: Text(
                      'አማርኛ',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleLarge!.color,
                      ),
                    ),
                  ),
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.en,
                    child: Text(
                      'English',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleLarge!.color,
                      ),
                    ),
                  ),
                ],
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).iconTheme.color!,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: deviceSize.width * 0.2,
          height: deviceSize.height * 0.15,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage(
                'assets/images/broccoli.png',
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.sign_in,
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge!.color,
            fontSize: deviceSize.width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: deviceSize.height * 0.03),
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
        SizedBox(
          height: deviceSize.height * 0.06,
          child: CustomFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: passwordController,
            obscure: obscure,
            hintText: AppLocalizations.of(context)!.password,
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
                AppLocalizations.of(context)!.forgot_password,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
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
                  if (formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          LoginEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                  }
                },
                text: AppLocalizations.of(context)!.sign_in,
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
            Text(
              AppLocalizations.of(context)!.or_log_in_with,
              style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge!.color,
              ),
            ),
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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
              AppLocalizations.of(context)!.do_not_have_an_account,
              style: TextStyle(
                fontSize: deviceSize.width * 0.036,
                color: Theme.of(context).textTheme.titleLarge!.color,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpPage.signUp);
              },
              child: Text(
                AppLocalizations.of(context)!.sign_up,
                style: TextStyle(
                  fontSize: deviceSize.width * 0.04,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  text(String text) {
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
