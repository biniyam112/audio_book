import 'package:audio_books/feature/register_user/bloc/register_user_bloc.dart';
import 'package:audio_books/feature/register_user/bloc/register_user_event.dart';
import 'package:audio_books/feature/register_user/bloc/register_user_state.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/screens/components/form_error.dart';
import 'package:audio_books/screens/components/tab_view.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../sizeConfig.dart';
import '../../components/input_field_container.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>
    with SingleTickerProviderStateMixin {
  late String firstName = '', lastName = '';
  late AnimationController rippleAnimationController;
  bool signUpLoading = false;
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    rippleAnimationController = AnimationController(
      vsync: this,
      duration: fastDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputFieldContainer(
            title: 'First name',
            child: buildFirstNameField(),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          InputFieldContainer(
            title: 'Last name',
            child: buildLastNameField(),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(20)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          BlocListener<RegisterUserBloc, RegisterUserState>(
            listener: (blocContext, state) {
              if (state is RegsiteringUserState) {
                signUpLoading = true;
                rippleAnimationController.forward();
              }
              if (state is UserRegisteredState) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TabViewPage();
                    },
                  ),
                );
              }
              if (state is RegsiteringUserFailedState) {
                signUpLoading = false;
                rippleAnimationController.stop();
                buildShowSnackBar(context, state.errorMessage);
              }
            },
            child: ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: signUpLoading
                    ? Center(
                        child: Row(
                          children: [
                            SpinKitRipple(
                              borderWidth: 2,
                              color: Colors.white,
                              size: 10,
                              controller: rippleAnimationController,
                            ),
                            horizontalSpacing(6),
                            Text('Loading'),
                          ],
                        ),
                      )
                    : Text('Register'),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var user = getIt.get<User>();
                  user.setFirstName = firstName;
                  user.setLastName = lastName;
                  BlocProvider.of<RegisterUserBloc>(context).add(
                    RegisterUserEvent(user: getIt.get<User>()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void buildShowSnackBar(BuildContext context, String errorMessage) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 10,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(),
        duration: Duration(seconds: 3),
        backgroundColor: isDarkMode ? Darktheme.backgroundColor : Colors.white,
        content: Expanded(
          child: Container(
            width: SizeConfig.screenWidth,
            height: getProportionateScreenHeight(40),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  errorMessage,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.red[400],
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ),
        ),
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
}
