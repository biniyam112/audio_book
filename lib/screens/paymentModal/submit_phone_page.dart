import 'package:audio_books/constants.dart';
import 'package:audio_books/feature/payment/bloc/payment_bloc.dart';
import 'package:audio_books/feature/payment/bloc/payment_event.dart';
import 'package:audio_books/feature/payment/bloc/payment_state.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/screens/paymentModal/build_phone_field.dart';
import 'package:audio_books/screens/screens.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../sizeConfig.dart';

class SubmitPhonePage extends StatefulWidget {
  const SubmitPhonePage({
    Key? key,
    required this.toNextPage,
  }) : super(key: key);
  final void Function({required String phoneNumber}) toNextPage;

  @override
  _SubmitPhonePageState createState() => _SubmitPhonePageState();
}

class _SubmitPhonePageState extends State<SubmitPhonePage> {
  final List<String> errors = [];
  var user = getIt.get<User>();
  late Country _selectedCountry;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController textFieldController;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(user.countryCode);
    print(user.phoneNumber);
    textFieldController = TextEditingController(text: '${user.phoneNumber}');
    _selectedCountry = Country.fromJson(
      {
        "country_code": "ET",
        "name": "Ethiopia",
        "calling_code": "+251",
        "flag": "flags/eth.png"
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hey ${user.firstName} ${user.lastName},',
          style: Theme.of(context).textTheme.headline4,
        ),
        verticalSpacing(6),
        Row(
          children: [
            Text(
              'Continue with phone number  ',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              '${user.countryCode}${user.phoneNumber} ?',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        verticalSpacing(SizeConfig.screenHeight! * .06),
        Form(
          key: _formKey,
          child: InputFieldContainer(
            title: 'Phone number',
            spacing: 8,
            child: BuildPhoneField(
              errors: errors,
              country: _selectedCountry,
              controller: _controller,
            ),
          ),
        ),
        verticalSpacing(8),
        BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, paymentState) {
          if (paymentState is OtpOnprocess) {
            return Center(
              child: Container(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(
                  color: Darktheme.primaryColor,
                ),
              ),
            );
          }
          return FormError(errors: errors);
        }),
        Spacer(),
        BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, paymentState) {
            if (paymentState is OtpCompleted) {
              errors.remove(kOtpError);
              widget.toNextPage(
                phoneNumber:
                    '${_selectedCountry.callingCode}${_controller.text.replaceAll(' ', '')}',
              );
            }
            if (paymentState is OtpFailed) {
              setState(() {
                if (!errors.contains(kOtpError)) errors.add(kOtpError);
              });
            }
          },
          builder: (context, paymentState) {
            return SizedBox(
              height: getProportionateScreenHeight(40),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (paymentState is OtpOnprocess)
                    ? null
                    : () {
                        print(errors);
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<PaymentBloc>(context).add(
                            SendOtp(
                              phoneNumber:
                                  '${_selectedCountry.callingCode}${_controller.text.replaceAll(' ', '')}',
                            ),
                          );
                        }
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 6,
                  ),
                  child: Text(
                    'Get otp',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            );
          },
        ),
        verticalSpacing(20),
      ],
    );
  }
}
