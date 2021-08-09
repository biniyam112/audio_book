import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../sizeConfig.dart';

class PhoneForm extends StatefulWidget {
  const PhoneForm({
    Key? key,
  }) : super(key: key);

  @override
  _PhoneFormState createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  Country? _selectedCountry;
  late String phoneNumber;

  void _showCountryPicker() async {
    final country = await showCountryPickerSheet(
      context,
      title: Text(
        'Select Country',
        style: Theme.of(context).textTheme.headline4,
      ),
      heightFactor: .8,
      cancelWidget: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Darktheme.primaryColor,
                ),
          ),
        ),
      ),
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final country = _selectedCountry;
    return InputFieldContainer(
      title: 'Phone',
      child: TextFormField(
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black),
        onChanged: (value) {
          phoneNumber = value;
        },
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(10),
          ),
          hintText: 'phone',
          hintStyle: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.black45),
          prefix: GestureDetector(
            onTap: () {
              _showCountryPicker();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                country == null
                    ? Padding(
                        padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(10),
                          left: 2,
                        ),
                        child: Icon(CupertinoIcons.chevron_up),
                      )
                    : Container(
                        height: getProportionateScreenWidth(30),
                        width: getProportionateScreenWidth(30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(10),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(10),
                          ),
                          child: Image.asset(
                            country.flag,
                            package: countryCodePackageName,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                if (country != null)
                  Padding(
                    padding: EdgeInsets.only(left: 6, right: 18),
                    child: Text(
                      country.callingCode,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
