import 'package:audio_books/constants.dart';
import 'package:audio_books/feature/payment/bloc/payment_bloc.dart';
import 'package:audio_books/feature/payment/bloc/payment_event.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/screens/screens.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../sizeConfig.dart';
import 'subscribtion_modal_card.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textFieldController = TextEditingController();
  List<String> errors = [];
  var user = getIt.get<User>();
  int? selectedPlan;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight! * .4,
      width: SizeConfig.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Enter OTP',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Form(
            key: _formKey,
            child: InputFieldContainer(
              title: 'Enter OTP',
              child: TextFormField(
                controller: textFieldController,
                validator: (value) {
                  if (value!.isEmpty && !errors.contains(kCodeNullError)) {
                    setState(() {
                      errors.add(kCodeNullError);
                    });
                    return '';
                  }
                  if (value.isEmpty && errors.contains(kCodeNullError)) {
                    return '';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty && errors.contains(kCodeNullError)) {
                    setState(() {
                      errors.remove(kCodeNullError);
                    });
                  }
                },
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.black.withOpacity(.8),
                      fontWeight: FontWeight.w500,
                    ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: 'otp code',
                  suffixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      getProportionateScreenWidth(10),
                      getProportionateScreenWidth(20),
                      getProportionateScreenWidth(10),
                    ),
                    child: SvgPicture.asset('assets/icons/Phone.svg'),
                  ),
                ),
              ),
            ),
          ),
          verticalSpacing(6),
          FormError(errors: errors),
          verticalSpacing(10),
          Text(
            'Select Subscription plan',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          verticalSpacing(10),
          Align(
            alignment: Alignment.center,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                childAspectRatio: 1.8,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                List<Color> subCardColors = [
                  Colors.greenAccent[700]!,
                  Colors.amber[700]!,
                  Colors.orange[700]!,
                ];
                return SubscribtionPlanCard(
                  amount: '100',
                  color: subCardColors[index],
                  duration: '1 year',
                  isselected: selectedPlan == index,
                  title: 'Premiun',
                  onPress: () {
                    setState(() {
                      selectedPlan = index;
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(40),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<PaymentBloc>(context).add(
                    CommitPayment(
                      phoneNumber: '',
                      pin: textFieldController.text,
                      amount: 100,
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Verify',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
          verticalSpacing(10),
        ],
      ),
    );
  }
}
