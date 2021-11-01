import 'package:audio_books/feature/authorize_user/bloc/authorize_user_bloc.dart';
import 'package:audio_books/feature/otp/bloc/bloc.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/screens/components/form_error.dart';
import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/screens/otp/otp.dart';
import 'package:audio_books/screens/phone_registration/phone_registration.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  String phoneNumber = '';
  String countryCode = '';
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorizeUserBloc, AuthoriseUserState>(
      listener: (context, authstate) {
        if (authstate == AuthoriseUserState.userAuthorizationFailedState) {
          setState(() {
            errors.add(kUserAuthorizationError);
          });
        }
        if (authstate == AuthoriseUserState.userAuthorizingState) {
          setState(() {
            errors.remove(kUserAuthorizationError);
          });
        }
        if (authstate == AuthoriseUserState.userAuthorizedState) {
          BlocProvider.of<OtpBloc>(context)
              .add(SendOtp(phoneNumber: phoneNumber));
          if (errors.contains(kOtpError)) errors.remove(kOtpError);
        }
      },
      builder: (context, authstate) {
        return BlocConsumer<OtpBloc, OtpState>(listener: (context, otpstate) {
          if (otpstate is OtpSent) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return OTPScreen(fromLogin: true);
                },
              ),
            );
          }
          if (otpstate is OtpFailure) {
            errors.add(kOtpError);
          }
        }, builder: (context, otpstate) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                InputFieldContainer(
                  title: 'Phone number',
                  subtitle: 'Include country code',
                  child: buildPhoneField(),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
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
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                if (authstate == AuthoriseUserState.userAuthorizingState ||
                    otpstate is OtpInProgress)
                  Center(
                    child: CircularProgressIndicator(
                      color: Darktheme.primaryColor,
                    ),
                  ),
                if (authstate == AuthoriseUserState.idleState ||
                    authstate ==
                        AuthoriseUserState.userAuthorizationFailedState ||
                    (authstate == AuthoriseUserState.userAuthorizedState &&
                        !(otpstate is OtpInProgress)))
                  ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Login'),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var user = getIt.get<User>();
                        user.phoneNumber = phoneNumber;
                        user.countryCode = countryCode;
                        _formKey.currentState!.save();
                        BlocProvider.of<AuthorizeUserBloc>(context)
                            .add(AuthoriseUserEvent.authorizeUser);
                      }
                    },
                  ),
              ],
            ),
          );
        });
      },
    );
  }

// ?phone formfield
  TextFormField buildPhoneField() {
    return TextFormField(
      onSaved: (newValue) {
        setState(() {
          phoneNumber = newValue!;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPhoneNullError)) {
          setState(() {
            errors.remove(kPhoneNullError);
          });
        }
        setState(() {
          phoneNumber = value;
        });
      },
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPhoneNullError)) {
          setState(() {
            errors.add(kPhoneNullError);
          });
          return '';
        } else if (value.isEmpty && errors.contains(kPhoneNullError)) {
          return '';
        }

        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9+]+')),
      ],
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
