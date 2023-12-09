import 'package:flutter/material.dart';
import 'package:grocery/data/service.dart';
import 'package:grocery/presentation/auth/widgets/custom_button.dart';
import 'package:grocery/presentation/auth/widgets/form_field.dart';
import 'package:grocery/presentation/base-home-page/view/base_home.dart';

import '../../data/models/user.dart';

class UpdateProfilePage extends StatefulWidget {
  User user;
  UpdateProfilePage({required this.user});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Update profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 100,
          vertical: 100,
        ),
        child: Column(
          children: [
            CustomFormField(
              controller: userNameController,
              hintText: 'Enter user name',
            ),
            const SizedBox(height: 20),
            CustomButton(function: updateUserName, text: 'Update')
          ],
        ),
      ),
    );
  }

  void updateUserName() async {
    User updatedUser = User(
      userName: userNameController.text,
      email: widget.user.email,
      password: widget.user.password,
    );
    if (userNameController.text.isNotEmpty) {
      await UserServies.updateUserInDB(updatedUser);
      var a = await UserServies.getUserFromDB();
      for (int i = 0; i < a.length; i++) {
        print(a[i].userName);
      }
      await Navigator.of(context).pushNamed(
        BaseHomePage.baseHomePage,
        arguments: updatedUser,
      );
    }
  }
}
