import 'package:audio_books/feature/payment/bloc/payment_bloc.dart';
import 'package:audio_books/screens/login/login.dart';
import 'package:audio_books/screens/settings/components/delete_dialog.dart';
import 'package:audio_books/services/hiveConfig/hive_config.dart';

import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsBottom extends StatelessWidget {
  const SettingsBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            var userBox = HiveBoxes.getUserBox();
            HiveBoxes.deleteUser();
            await userBox.clear();
            Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
              LoginScreen.pageRoute,
              (route) => false,
            );
          },
          child: Text('Logout',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.w600)),
          style: ElevatedButton.styleFrom(
            elevation: 0.5,
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            primary: isDarkMode
                ? Darktheme.containerColor
                : LightTheme.backgroundColor,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(30)),
          child: Column(
            children: [
              Image.asset('assets/launcher_icon.png',
                  height: getProportionateScreenHeight(60)),
              Text('Version${PaymentBloc.appVersion}',
                  style: TextStyle(height: .5))
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return DeleteDialog();
                  });
            },
            child: Text(
              'Delete Account',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w600, color: Colors.red.shade400),
            ),
            style: ElevatedButton.styleFrom(
              elevation: .5,
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10)),
              primary: isDarkMode
                  ? Darktheme.containerColor
                  : LightTheme.backgroundColor,
            ))
      ],
    );
  }
}
