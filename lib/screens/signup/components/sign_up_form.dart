import 'package:audio_books/screens/components/form_error.dart';
import 'package:audio_books/screens/phone_registration/phone_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../sizeConfig.dart';
import '../../components/input_field_container.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late String email = '', password = '', confirmPassword = '';
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputFieldContainer(
            title: 'Email',
            child: buildEmailFormField(),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          InputFieldContainer(
            title: 'Password',
            child: buildPasswordFormField(),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          InputFieldContainer(
            title: 'Confirm password',
            child: buildConfirmPasswordFormField(),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Sign up'),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
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

//? confirm password form filed
  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) {
        setState(() {
          confirmPassword = newValue!;
        });
      },
      onChanged: (value) {
        if (confirmPassword == password && errors.contains(kMatchPassError)) {
          setState(() {
            errors.remove(kMatchPassError);
          });
        }
        setState(() {
          confirmPassword = value;
        });
      },
      validator: (value) {
        if (confirmPassword != password && !errors.contains(kMatchPassError)) {
          setState(() {
            errors.add(kMatchPassError);
          });
          return '';
        } else if (confirmPassword != password &&
            errors.contains(kMatchPassError)) {
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Color(0xffA2BAEA),
        hintText: 'confirm password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(20),
          ),
          child: SvgPicture.asset('assets/icons/Lock.svg'),
        ),
      ),
    );
  }

//? password form field
  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) {
        password = newValue!;
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
        setState(() {
          password = value;
        });
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
          return '';
        } else if (value.length != 0 &&
            value.length < 8 &&
            !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
          return '';
        } else if ((value.isEmpty && errors.contains(kPassNullError)) ||
            (value.length < 8 && errors.contains(kShortPassError))) {
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        errorMaxLines: 1,
        hintText: 'password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(20),
          ),
          child: SvgPicture.asset('assets/icons/Lock.svg'),
        ),
      ),
    );
  }

// ? email form field
  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (newValue) {
        setState(() {
          email = newValue!;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        setState(() {
          email = value;
        });
      },
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
          return '';
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
          return '';
        } else if ((value.isEmpty && errors.contains(kEmailNullError)) ||
            (!emailValidatorRegExp.hasMatch(value) &&
                errors.contains(kInvalidEmailError))) {
          return '';
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: 'enter email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(20),
          ),
          child: SvgPicture.asset('assets/icons/Mail.svg'),
        ),
      ),
    );
  }
}
