import 'package:audio_books/screens/settings/settings.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../apptheme.dart';
import 'components.dart';

class ProfileBottom extends StatefulWidget {
  const ProfileBottom({Key? key}) : super(key: key);

  @override
  _ProfileBottomState createState() => _ProfileBottomState();
}

class _ProfileBottomState extends State<ProfileBottom> {
  final _editFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      height: SizeConfig.screenHeight! * .624,
      child: Form(
        key: _editFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldClipper(
              child: TextFormField(
                decoration: AppTheme.textFieldDecoration("First Name"),
              ),
            ),
            TextFieldClipper(
              child: TextFormField(
                decoration: AppTheme.textFieldDecoration("Last Name"),
              ),
            ),
            TextFieldClipper(
              child: TextFormField(
                decoration: AppTheme.textFieldDecoration("Email"),
              ),
            ),
            TextFieldClipper(
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: AppTheme.textFieldDecoration("Phone"),
              ),
            ),
            TextFieldClipper(
              child: TextFormField(
                obscureText: true,
                decoration: AppTheme.textFieldDecoration("Password"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Cancel",
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                    style: AppTheme.getElevatedButtonStyle(
                        Colors.grey.shade300,
                        5,
                        EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(25))),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Save",
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade100),
                    ),
                    style: AppTheme.getElevatedButtonStyle(
                        Colors.orange,
                        5,
                        EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(30))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
