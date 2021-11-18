import 'package:audio_books/feature/authorize_user/bloc/authorize_user_bloc.dart';
import 'package:audio_books/feature/otp/bloc/bloc.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/screens/components/form_error.dart';
import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/screens/otp/otp.dart';
import 'package:audio_books/screens/phone_registration/phone_registration.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../../../constants.dart';
import '../../../sizeConfig.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String phoneNumber = '';
  late Country _selectedCountry;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _selectedCountry = Country.fromJson(
      {
        "country_code": "ET",
        "name": "Ethiopia",
        "calling_code": "+251",
        "flag": "flags/eth.png"
      },
    );
  }

  String modifyText() {
    String text = _controller.text.replaceAll(' ', '');
    List textList = text.split("");
    for (var i = 0; i < textList.length; i++) {
      if (i % 4 == 0) textList.insert(i, ' ');
    }
    return textList.join();
  }

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
        if (errors.contains(kCountryCodeNullError)) {
          errors.remove(kCountryCodeNullError);
        }
        GetIt.instance;
        var user = getIt.get<User>();
        user.setCountryCode = country.callingCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorizeUserBloc, AuthoriseUserState>(
      listener: (context, authstate) {
        if (authstate is UserAuthorizationFailedState) {
          setState(() {
            print(authstate.errorMessage);
            if (authstate.errorMessage.contains(kPhoneNotRegisteredError)) {
              if (!errors.contains(kPhoneNotRegisteredError)) {
                errors.add(kPhoneNotRegisteredError);
              }
            } else {
              if (!errors.contains(kUserAuthorizationError))
                errors.add(kUserAuthorizationError);
            }
          });
        }
        if (authstate is UserAuthorizingState) {
          setState(() {
            errors.remove(kUserAuthorizationError);
            errors.remove(kPhoneNotRegisteredError);
          });
        }
        if (authstate is UserAuthorizedState) {
          BlocProvider.of<OtpBloc>(context).add(
            SendOtp(
              phoneNumber: '${_selectedCountry.callingCode}$phoneNumber',
            ),
          );
          if (errors.contains(kOtpError)) errors.remove(kOtpError);
        }
      },
      builder: (context, authstate) {
        return BlocConsumer<OtpBloc, OtpState>(
          listener: (context, otpstate) {
            if (otpstate is OtpSent) {
              Navigator.popAndPushNamed(
                context,
                OTPScreen.pageRoute,
                arguments: true,
              );
            }
            if (otpstate is OtpFailure) {
              errors.add(kOtpError);
            }
          },
          builder: (context, otpstate) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(20)),
                  InputFieldContainer(
                    title: 'Phone number',
                    child: buildPhoneField(authstate: authstate),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  FormError(errors: errors),
                  if (errors.isNotEmpty)
                    SizedBox(height: getProportionateScreenHeight(40)),
                  if (authstate is UserAuthorizingState ||
                      otpstate is OtpInProgress)
                    Center(
                      child: CircularProgressIndicator(
                        color: Darktheme.primaryColor,
                      ),
                    ),
                  if (authstate is IdleState ||
                      authstate is UserAuthorizationFailedState ||
                      (authstate is UserAuthorizedState &&
                          !(otpstate is OtpInProgress)))
                    SizedBox(
                      height: getProportionateScreenHeight(42),
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Login',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                        onPressed: () {
                          if (_selectedCountry.callingCode.isEmpty &&
                              !errors.contains(kCountryCodeNullError)) {
                            setState(() {
                              errors.add(kCountryCodeNullError);
                            });
                          } else if (_formKey.currentState!.validate() &&
                              !errors.contains(kCountryCodeNullError)) {
                            var user = getIt.get<User>();
                            user.phoneNumber = phoneNumber;
                            user.countryCode = _selectedCountry.callingCode;
                            _formKey.currentState!.save();
                            BlocProvider.of<AuthorizeUserBloc>(context)
                                .add(AuthoriseUserEvent.authorizeUser);
                          }
                        },
                      ),
                    ),
                  SizedBox(height: getProportionateScreenHeight(100)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: (otpstate is OtpInProgress ||
                                authstate is UserAuthorizingState)
                            ? null
                            : () {
                                Navigator.popAndPushNamed(
                                    context, PhoneRegistrationScreen.pageRoute);
                              },
                        child: Text(
                          'Sign up',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

// ?phone formfield
  TextFormField buildPhoneField({required AuthoriseUserState authstate}) {
    return TextFormField(
      controller: _controller,
      style: Theme.of(context).textTheme.headline5!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPhoneNullError)) {
          setState(() {
            errors.add(kPhoneNullError);
          });
          return '';
        }
        if (value.isEmpty && errors.contains(kPhoneNullError)) {
          return '';
        }
      },
      onChanged: (authstate is UserAuthorizingState)
          ? null
          : (value) {
              _controller.text = modifyText();
              _controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: _controller.text.length));
              if (value.isNotEmpty && errors.contains(kPhoneNullError)) {
                setState(() {
                  errors.remove(kPhoneNullError);
                });
              }
              phoneNumber = value.replaceAll(' ', '');
              var user = getIt.get<User>();
              user.setPhoneNumber = value;
            },
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: 16,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            getProportionateScreenWidth(10),
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(10),
          ),
          child: SvgPicture.asset('assets/icons/Phone.svg'),
        ),
        hintText: 'phone',
        hintStyle: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black45),
        prefixIcon: GestureDetector(
          onTap: () {
            _showCountryPicker();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
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
                    _selectedCountry.flag,
                    package: countryCodePackageName,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6, right: 18),
                child: Text(
                  _selectedCountry.callingCode,
                  style: TextStyle(
                    color: Colors.black,
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
