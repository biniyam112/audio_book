import 'package:audio_books/screens/components/form_error.dart';
import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/screens/phone_registration/phone_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../sizeConfig.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputFieldContainer(
            child: buildFirstNameField(),
            title: 'First name',
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          InputFieldContainer(
            child: buildLastNameField(),
            title: 'Last name',
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          InputFieldContainer(
            title: 'Phone number',
            subtitle: 'Include country code',
            child: buildPhoneField(),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account?'),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PhoneRegistrationScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Login'),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PhoneRegistrationScreen();
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

// ? firstName form field
  TextFormField buildFirstNameField() {
    return TextFormField(
      onSaved: (newValue) {
        setState(() {
          firstName = newValue!;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kFirstNameNullError)) {
          setState(() {
            errors.remove(kFirstNameNullError);
          });
        }
        setState(() {
          firstName = value;
        });
      },
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kFirstNameNullError)) {
          setState(() {
            errors.add(kFirstNameNullError);
          });
          return '';
        } else if (value.isEmpty && errors.contains(kFirstNameNullError)) {
          return '';
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: 'First name',
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(20),
          ),
          child: SvgPicture.asset('assets/icons/User.svg'),
        ),
      ),
    );
  }

  // ? lastname form field
  TextFormField buildLastNameField() {
    return TextFormField(
      onSaved: (newValue) {
        setState(() {
          lastName = newValue!;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(klastNameNullError)) {
          setState(() {
            errors.remove(klastNameNullError);
          });
        }
        setState(() {
          lastName = value;
        });
      },
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty && !errors.contains(klastNameNullError)) {
          setState(() {
            errors.add(klastNameNullError);
          });
          return '';
        } else if (value.isEmpty && errors.contains(klastNameNullError)) {
          return '';
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: 'Last name',
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(20),
          ),
          child: SvgPicture.asset('assets/icons/User.svg'),
        ),
      ),
    );
  }

  TextFormField buildPhoneField() {
    return TextFormField(
      onSaved: (newValue) {
        setState(() {
          lastName = newValue!;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(klastNameNullError)) {
          setState(() {
            errors.remove(klastNameNullError);
          });
        }
        setState(() {
          lastName = value;
        });
      },
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty && !errors.contains(klastNameNullError)) {
          setState(() {
            errors.add(klastNameNullError);
          });
          return '';
        } else if (value.isEmpty && errors.contains(klastNameNullError)) {
          return '';
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: 'Phone number',
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(20),
          ),
          child: SvgPicture.asset('assets/icons/Phone.svg'),
        ),
      ),
    );
  }
}
