import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Dialog(
      child: Container(
        height: getProportionateScreenHeight(200),
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(15),
            horizontal: getProportionateScreenWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Delete Account',
                style: Theme.of(context).textTheme.headline4!),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Text(
                'Are you sure you want to delete this Account? If you delete this account you will permanently lose your data',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    ' Cancel ',
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: .5,
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(30)),
                    primary: isDarkMode
                        ? Darktheme.containerColor
                        : LightTheme.backgroundColor,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: .5, primary: Colors.red),
                    child: Text(
                      'Confirm Deletion',
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
