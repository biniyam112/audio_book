import 'package:audio_books/screens/components/tab_view.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int phoneNumber = 23234324;
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
                      text: '+251 $phoneNumber',
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
            ],
          ),
        ),
      ),
    );
  }

  void verifyPin(String pin, BuildContext context) {
    if (pin == '123456') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return TabViewPage();
          },
        ),
      );
    }
  }
}
