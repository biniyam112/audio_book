import 'package:audio_books/feature/otp/bloc/bloc.dart';
import 'package:audio_books/feature/otp/bloc/otp_bloc.dart';
import 'package:audio_books/screens/components/tab_view.dart';
import 'package:audio_books/screens/signup/signup_screen.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.fromLogin}) : super(key: key);
  final bool fromLogin;

  @override
  Widget build(BuildContext context) {
    String phoneNumber = '';

    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpVerified) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return fromLogin ? TabViewPage() : SignupScreen();
              },
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is OtpSent) phoneNumber = state.phoneNumber;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: SizeConfig.screenHeight! * .1),
                  Container(
                    height: SizeConfig.screenHeight! * .4,
                    width: SizeConfig.screenWidth,
                    child: Image.asset('assets/images/verify_phone.jpg'),
                  ),
                  Text(
                    'Phone number verification',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 16,
                          ),
                      children: [
                        TextSpan(text: 'Text has been sent to '),
                        TextSpan(
                          text: '$phoneNumber ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * .05),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: PinCodeTextField(
                      appContext: context,
                      pinTheme: PinTheme(
                        inactiveColor: Colors.black54,
                        activeColor: Colors.green,
                        selectedColor: Colors.black,
                      ),
                      keyboardType: TextInputType.number,
                      length: 6,
                      onChanged: (pin) {},
                      onCompleted: (pin) {
                        verifyPin(pin, context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Haven\'t receive the code?'),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'resend',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  state is OtpInProgress
                      ? CircularProgressIndicator(
                          color: Colors.orange,
                        )
                      : state is OtpValidationError
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.dangerous_rounded,
                                  color: Colors.red,
                                ),
                                Text(" phone auth credential is invalid")
                              ],
                            )
                          : Container()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void verifyPin(String pin, BuildContext context) {
    BlocProvider.of<OtpBloc>(context).add(VerifyOtp(otp: pin));
  }
}
