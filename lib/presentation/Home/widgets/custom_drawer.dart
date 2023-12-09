import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:grocery/data/models/user.dart';
import 'package:grocery/presentation/auth/widgets/custom_button.dart';
import 'package:grocery/presentation/update-profile/update-profile.dart';

import '../../auth/view/signin.dart';

class CustomDrawer extends StatelessWidget {
  User user;
  CustomDrawer({required this.user});
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            decoration: const BoxDecoration(
              color: Color(0xFFE67F1E),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(50),
              ),
            ),
            height: deviceSize.height * 0.3,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: deviceSize.width * 0.08,
                  child: Text(
                    user.userName![0],
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.06,
                      color: const Color(0xFFE67F1E),
                    ),
                  ),
                ),
                SizedBox(height: deviceSize.height * 0.02),
                Text(
                  user.userName!,
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.04,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user.email!,
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.04,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          divider(deviceSize),
          InkWell(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdateProfilePage(user: user),
                ),
              );
            },
            child: const ListTile(
              leading: Icon(
                Icons.edit_outlined,
                color: Color(0xFFE67F1E),
              ),
              title: Text('Update profile'),
            ),
          ),
          divider(deviceSize),
          InkWell(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.lock_outline,
                color: Color(0xFFE67F1E),
              ),
              title: Text('Privacy'),
            ),
          ),
          divider(deviceSize),
          InkWell(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                FontAwesome.file_text_o,
                color: Color(0xFFE67F1E),
              ),
              title: Text('Terms and conditions'),
            ),
          ),
          divider(deviceSize),
          InkWell(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.help_outline,
                color: Color(0xFFE67F1E),
              ),
              title: Text('Support'),
            ),
          ),
          divider(deviceSize),
          InkWell(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Color(0xFFE67F1E),
              ),
              title: Text('About us'),
            ),
          ),
          divider(deviceSize),
          SizedBox(height: deviceSize.width * 0.1),
          SizedBox(
            width: deviceSize.width * 0.5,
            child: CustomButton(
                function: () {
                  _dialog(context);
                },
                text: 'Log out'),
          )
        ],
      ),
    );
  }

  Divider divider(Size deviceSize) {
    return Divider(
      thickness: 1,
      indent: deviceSize.width * 0.05,
      endIndent: deviceSize.width * 0.05,
    );
  }

  void _dialog(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: deviceSize.height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Log out from this account?',
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                TextButton(
                  onPressed: () async {
                    await Navigator.of(context)
                        .pushReplacementNamed(SigninPage.signIn);
                  },
                  child: Text(
                    'Log out ',
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      color: Colors.red,
                    ),
                  ),
                ),
                const Divider(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        );
      },
    );
  }
}
