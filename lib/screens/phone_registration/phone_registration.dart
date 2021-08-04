import 'package:audio_books/screens/components/custom_appbar.dart';
import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/screens/otp/otp.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneRegistrationScreen extends StatelessWidget {
  const PhoneRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Verification'),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.screenHeight! * .16),
              Text(
                'Enter \nPhone number',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 30),
              ),
              verticalSpacing(10),
              Text(
                'we will send you verification code',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: isDarkMode ? Colors.white38 : Colors.black38,
                    ),
              ),
              verticalSpacing(40),
              PhoneForm(),
              verticalSpacing(12),
              Center(
                child: Container(
                  height: getProportionateScreenHeight(40),
                  width: getProportionateScreenWidth(100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (cotext) {
                            return OTPScreen();
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenWidth(6)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Next',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          horizontalSpacing(8),
                          Icon(
                            CupertinoIcons.chevron_right,
                            color: Colors.white,
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
      ),
    );
  }
}

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
