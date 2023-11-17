import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/presentation/Auth/bloc/auth_bloc.dart';
import 'package:grocery/presentation/BaseHomePage/View/base_home.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);
  static const signIn = 'signin';

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // write a function which compares two numbers
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid username/password'),
                duration: Duration(seconds: 2),
              ),
            );
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
    );
  }

  Widget buildScreen(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: deviceSize.height * 0.7,
                  child: Image.asset(
                    'assets/signin.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: deviceSize.height * 0.5,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: userNameController,
                            decoration: InputDecoration(
                              hintText: 'rafatul3588@gmail.com',
                              hintStyle: const TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: passwordController,
                            obscureText: obscure,
                            decoration: InputDecoration(
                              hintText: 'password',
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscure == true
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscure = !obscure;
                                    print(obscure);
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: deviceSize.height * 0.1),
                          Container(
                            height: deviceSize.height * 0.08,
                            width: deviceSize.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color(0xFFFEC54B),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
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
                                // Navigator.pushNamed(
                                //   context,
                                //   BaseHomePage.baseHomePage,
                                // );
                                // Navigator.of(context).pushReplacement(
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         const BaseHomePage(),
                                //   ),
                                // );
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
