import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:grocery/data/local/shered_preference.dart';
import 'package:grocery/main.dart';
import 'package:grocery/presentation/base-home-page/view/base_home.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/view/signin.dart';
import '../../auth/widgets/custom_button.dart';
import '../../update-profile/update-profile.dart';
import '../../../data/models/user.dart';

enum SampleItem { am, en }

class CustomDrawer extends StatefulWidget {
  final User user;

  CustomDrawer({super.key, required this.user});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
    getImagePath();
  }

  SampleItem? selectedMenu;
  String lang = 'en';

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? imagePath;
  Future getImagePath() async {
    imagePath = await LocalStorage.getString('image');
  }

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
            height: deviceSize.height * 0.35,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FutureBuilder(
                  future: getImagePath(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return GestureDetector(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    'Choose where you want to pick the image from',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: deviceSize.width * 0.045,
                                    ),
                                  ),
                                  content: Row(
                                    children: [
                                      SizedBox(
                                        width: deviceSize.width * 0.3,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            elevation: MaterialStateProperty
                                                .all<double>(0),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              const Color(0xFFE67F1E),
                                            ),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
                                            final XFile? image =
                                                await _picker.pickImage(
                                              source: ImageSource.camera,
                                            );
                                            setState(() async {
                                              _image = image;
                                              await LocalStorage.saveString(
                                                'image',
                                                image!.path,
                                              );
                                              // ignore: use_build_context_synchronously
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BaseHomePage(
                                                          user: widget.user),
                                                ),
                                              );
                                            });
                                          },
                                          child: Text(
                                            'Camera',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  deviceSize.width * 0.036,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: deviceSize.width * 0.3,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            elevation: MaterialStateProperty
                                                .all<double>(0),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              const Color(0xFFE67F1E),
                                            ),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
                                            final XFile? image =
                                                await _picker.pickImage(
                                              source: ImageSource.gallery,
                                            );
                                            setState(() async {
                                              _image = image;
                                              await LocalStorage.saveString(
                                                  'image', image!.path);
                                              // ignore: use_build_context_synchronously
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BaseHomePage(
                                                          user: widget.user),
                                                ),
                                              );
                                            });
                                          },
                                          child: Text(
                                            'Gallery',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  deviceSize.width * 0.036,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: deviceSize.width * 0.1,
                          backgroundImage: imagePath == null
                              ? null
                              : FileImage(File(imagePath!)),
                          child: imagePath == null
                              ? Text(
                                  widget.user.userName![0],
                                  style: TextStyle(
                                    fontSize: deviceSize.width * 0.06,
                                    color: const Color(0xFFE67F1E),
                                  ),
                                )
                              : null,
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(height: deviceSize.height * 0.02),
                Text(
                  DateTime.now().hour < 12
                      ? AppLocalizations.of(context)!.good_morning
                      : AppLocalizations.of(context)!.good_afternoon,
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.04,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.user.userName!,
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.04,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.user.email!,
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.04,
                    color: Colors.white,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ),
          divider(deviceSize),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: const Icon(
                FontAwesome.language,
                color: Color(0xFFE67F1E),
              ),
              title: Text(AppLocalizations.of(context)!.change_language),
              trailing: PopupMenuButton<SampleItem>(
                iconColor: const Color(0xFFE67F1E),
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
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.am,
                    child: Text('አማርኛ'),
                  ),
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.en,
                    child: Text('English'),
                  ),
                ],
              ),
            ),
          ),
          divider(deviceSize),
          InkWell(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdateProfilePage(user: widget.user),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(
                FontAwesome.edit,
                color: Color(0xFFE67F1E),
              ),
              title: Text(AppLocalizations.of(context)!.update_profile),
            ),
          ),
          divider(deviceSize),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: const Icon(
                FontAwesome.lock,
                color: Color(0xFFE67F1E),
              ),
              title: Text(AppLocalizations.of(context)!.privacy),
            ),
          ),
          divider(deviceSize),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: const Icon(
                FontAwesome.file_text_o,
                color: Color(0xFFE67F1E),
              ),
              title: Text(AppLocalizations.of(context)!.terms_and_conditions),
            ),
          ),
          divider(deviceSize),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: const Icon(
                FontAwesome.support,
                color: Color(0xFFE67F1E),
              ),
              title: Text(AppLocalizations.of(context)!.support),
            ),
          ),
          divider(deviceSize),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: const Icon(
                FontAwesome.info_circle,
                color: Color(0xFFE67F1E),
              ),
              title: Text(AppLocalizations.of(context)!.about_us),
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
              text: AppLocalizations.of(context)!.log_out,
            ),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: deviceSize.height * 0.032),
              Text(
                AppLocalizations.of(context)!.log_out_from_this_account,
                style: TextStyle(
                  fontSize: deviceSize.width * 0.05,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: deviceSize.height * 0.02),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          await Navigator.of(context)
                              .pushReplacementNamed(SigninPage.signIn);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.log_out,
                          style: TextStyle(
                            fontSize: deviceSize.width * 0.04,
                            color: const Color(0xFFE67F1E),
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 1,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: TextStyle(
                            fontSize: deviceSize.width * 0.04,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
