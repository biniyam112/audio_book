import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditUserBottom extends StatefulWidget {
  const EditUserBottom({Key? key}) : super(key: key);

  @override
  _EditUserBottomState createState() => _EditUserBottomState();
}

class _EditUserBottomState extends State<EditUserBottom> {
  final _editFormKey = GlobalKey<FormState>();
  User user = getIt.get<User>();

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
          children: [
            InputFieldContainer(
              title: 'First name',
              spacing: 8,
              child: TextFormField(
                initialValue: user.firstName,
                decoration: InputDecoration(
                  hintText: 'First name',
                ),
              ),
            ),
            verticalSpacing(20),
            InputFieldContainer(
              title: 'Last name',
              spacing: 8,
              child: TextFormField(
                initialValue: user.lastName,
                decoration: InputDecoration(
                  hintText: 'Last name',
                ),
              ),
            ),
            verticalSpacing(20),
            InputFieldContainer(
              title: 'Phone number',
              spacing: 8,
              child: TextFormField(
                initialValue: user.phoneNumber,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Phone number',
                ),
              ),
            ),
            Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[600],
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          "Cancel",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  horizontalSpacing(10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          "Save",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
