import 'package:audio_books/feature/register_user/bloc/register_user_bloc.dart';
import 'package:audio_books/feature/register_user/bloc/register_user_event.dart';
import 'package:audio_books/feature/register_user/bloc/register_user_state.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/screens/components/form_error.dart';
import 'package:audio_books/screens/components/tab_view.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
            child: buildFirstNameFormField(),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          InputFieldContainer(
            title: 'Last name',
            child: buildLastNameFormField(),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(20)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          BlocListener<RegisterUserBloc, RegisterUserState>(
            listener: (context, state) {
              if (state is RegsiteringUserState) {
                signUpLoading = !signUpLoading;
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Text(state.errorMessage),
                      ),
                    ),
                  ),
                );
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

//? confirm password form filed
  // TextFormField buildConfirmPasswordFormField() {
  //   return TextFormField(
  //     obscureText: true,
  //     onSaved: (newValue) {
  //       setState(() {
  //         confirmPassword = newValue!;
  //       });
  //     },
  //     onChanged: (value) {
  //       if (confirmPassword == password && errors.contains(kMatchPassError)) {
  //         setState(() {
  //           errors.remove(kMatchPassError);
  //         });
  //       }
  //       setState(() {
  //         confirmPassword = value;
  //       });
  //     },
  //     validator: (value) {
  //       if (confirmPassword != password && !errors.contains(kMatchPassError)) {
  //         setState(() {
  //           errors.add(kMatchPassError);
  //         });
  //         return '';
  //       } else if (confirmPassword != password &&
  //           errors.contains(kMatchPassError)) {
  //         return '';
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       fillColor: Color(0xffA2BAEA),
  //       hintText: 'confirm password',
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: Padding(
  //         padding: EdgeInsets.fromLTRB(
  //           0,
  //           getProportionateScreenWidth(20),
  //           getProportionateScreenWidth(20),
  //           getProportionateScreenWidth(20),
  //         ),
  //         child: SvgPicture.asset('assets/icons/Lock.svg'),
  //       ),
  //     ),
  //   );
  // }

//? password form field
//   TextFormField buildPasswordFormField() {
//     return TextFormField(
//       obscureText: true,
//       onSaved: (newValue) {
//         password = newValue!;
//       },
//       onChanged: (value) {
//         if (value.isNotEmpty && errors.contains(kPassNullError)) {
//           setState(() {
//             errors.remove(kPassNullError);
//           });
//         } else if (value.length >= 8 && errors.contains(kShortPassError)) {
//           setState(() {
//             errors.remove(kShortPassError);
//           });
//         }
//         setState(() {
//           password = value;
//         });
//       },
//       validator: (value) {
//         if (value!.isEmpty && !errors.contains(kPassNullError)) {
//           setState(() {
//             errors.add(kPassNullError);
//           });
//           return '';
//         } else if (value.length != 0 &&
//             value.length < 8 &&
  // !errors.contains(kShortPassError)) {
//           setState(() {
//             errors.add(kShortPassError);
//           });
//           return '';
//         } else if ((value.isEmpty && errors.contains(kPassNullError)) ||
//             (value.length < 8 && errors.contains(kShortPassError))) {
//           return '';
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         errorMaxLines: 1,
//         hintText: 'password',
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: Padding(
//           padding: EdgeInsets.fromLTRB(
//             0,
//             getProportionateScreenWidth(20),
//             getProportionateScreenWidth(20),
//             getProportionateScreenWidth(20),
//           ),
//           child: SvgPicture.asset('assets/icons/Lock.svg'),
//         ),
//       ),
//     );
//   }

// // ? email form field
//   TextFormField buildEmailFormField() {
//     return TextFormField(
//       onSaved: (newValue) {
//         setState(() {
//           email = newValue!;
//         });
//       },
//       onChanged: (value) {
//         if (value.isNotEmpty && errors.contains(kEmailNullError)) {
//           setState(() {
//             errors.remove(kEmailNullError);
//           });
//         } else if (emailValidatorRegExp.hasMatch(value) &&
//             errors.contains(kInvalidEmailError)) {
//           setState(() {
//             errors.remove(kInvalidEmailError);
//           });
//         }
//         setState(() {
//           email = value;
//         });
//       },
//       keyboardType: TextInputType.emailAddress,
//       validator: (value) {
//         if (value!.isEmpty && !errors.contains(kEmailNullError)) {
//           setState(() {
//             errors.add(kEmailNullError);
//           });
//           return '';
//         } else if (!emailValidatorRegExp.hasMatch(value) &&
//             !errors.contains(kInvalidEmailError)) {
//           setState(() {
//             errors.add(kInvalidEmailError);
//           });
//           return '';
//         } else if ((value.isEmpty && errors.contains(kEmailNullError)) ||
//             (!emailValidatorRegExp.hasMatch(value) &&
//                 errors.contains(kInvalidEmailError))) {
//           return '';
//         }

//         return null;
//       },
//       decoration: InputDecoration(
//         hintText: 'enter email',
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: Padding(
//           padding: EdgeInsets.fromLTRB(
//             0,
//             getProportionateScreenWidth(20),
//             getProportionateScreenWidth(20),
//             getProportionateScreenWidth(20),
//           ),
//           child: SvgPicture.asset('assets/icons/Mail.svg'),
//         ),
//       ),
//     );
//   }

// ? firstName form field
  TextFormField buildFirstNameFormField() {
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
  } // ? lastname form field

  TextFormField buildLastNameFormField() {
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
