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

import '../../../constants.dart';
import '../../../sizeConfig.dart';
import '../../components/input_field_container.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late String firstName = '', lastName = '';
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterUserBloc, RegisterUserState>(
        listener: (blocContext, state) {
      if (state is RegsiteringUserState) {
        errors.remove(kPhoneInUseError);
        errors.remove(kConnectionError);
      }
      if (state is UserRegisteredState) {
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
        setState(() {
          if (state.errorMessage.contains('Phone'))
            errors.add(kPhoneInUseError);
          else
            errors.add(kConnectionError);
        });
      }
    }, builder: (context, state) {
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
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(40)),
            if (state is RegsiteringUserState)
              Center(
                child: CircularProgressIndicator(
                  color: Darktheme.primaryColor,
                ),
              ),
            if (state is IdleState || state is RegsiteringUserFailedState)
              ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Register'),
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
          ],
        ),
      );
    });
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
        if (value.isNotEmpty && errors.contains(kLastNameNullError)) {
          setState(() {
            errors.remove(kLastNameNullError);
          });
        }
        setState(() {
          lastName = value;
        });
      },
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kLastNameNullError)) {
          setState(() {
            errors.add(kLastNameNullError);
          });
          return '';
        } else if (value.isEmpty && errors.contains(kLastNameNullError)) {
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
