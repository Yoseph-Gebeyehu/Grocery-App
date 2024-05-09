import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../presentation/auth/widgets/custom_button.dart';
import '../../presentation/auth/widgets/form_field.dart';
import '../../presentation/base-home-page/view/base_home.dart';
import '../../data/service.dart';
import '../../data/models/user.dart';

class UpdateProfilePage extends StatefulWidget {
  final User user;
  const UpdateProfilePage({super.key, required this.user});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
        title: Text(
          AppLocalizations.of(context)!.update,
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge!.color,
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
              prefix: const Icon(Icons.person_outline),
              keyboardType: TextInputType.name,
              controller: userNameController,
              hintText: AppLocalizations.of(context)!.enter_user_name,
            ),
            const SizedBox(height: 20),
            CustomButton(
              function: updateUserName,
              text: AppLocalizations.of(context)!.update,
            )
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
      // var a = await UserServies.getUserFromDB();
      // for (int i = 0; i < a.length; i++) {
      //   print(a[i].userName);
      // }
      await Navigator.of(context).pushNamed(
        BaseHomePage.baseHomePage,
        arguments: updatedUser,
      );
    }
  }
}
