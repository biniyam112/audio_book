import 'package:audio_books/constants.dart';
import 'package:audio_books/feature/payment/bloc/payment_bloc.dart';
import 'package:audio_books/feature/payment/bloc/payment_event.dart';
import 'package:audio_books/feature/payment/bloc/payment_state.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/screens/screens.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../sizeConfig.dart';
import 'subscribtion_modal_card.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key, required this.phoneNumber, required this.onPress})
      : super(key: key);
  final String phoneNumber;
  final GestureTapCallback onPress;

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textFieldController = TextEditingController();
  List<String> errors = [];
  int? selectedPlan;
  late List<Subscribtion> subscriptions;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PaymentBloc>(context).add(FetchPlans());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<PaymentBloc>(context).add(FetchPlans());
            },
            child: Text(
              'Enter OTP',
              style: Theme.of(context).textTheme.headline4,
            ),
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
        BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, paymentState) {
            if (paymentState is PaymentOnprocess) {
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
          },
        ),
        verticalSpacing(20),
        Text(
          'Select Subscription plan',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        verticalSpacing(10),
        Align(
          alignment: Alignment.center,
          child: BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, plansstate) {
              if (plansstate is PlansFetching) {
                SizedBox(
                  height: getProportionateScreenHeight(120),
                  child: Center(
                    child: SizedBox(
                      height: 32,
                      width: 32,
                      child: CircularProgressIndicator(
                        color: Darktheme.primaryColor,
                      ),
                    ),
                  ),
                );
              }
              if (plansstate is PlansFetched) {
                var plans = plansstate.plans;
                subscriptions = plans;
                if (plans.isEmpty) {
                  return SizedBox(
                    height: getProportionateScreenHeight(120),
                    child: Center(
                      child: Text(
                        'There are no available plans',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  );
                }
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.8,
                  ),
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    return SubscribtionPlanCard(
                      title: '${plans[index].name}',
                      description: '${plans[index].description}',
                      amount: '${plans[index].fee}',
                      duration: '${plans[index].duration.inDays}',
                      isselected: selectedPlan == index,
                      onPress: () {
                        setState(() {
                          selectedPlan = index;
                          errors.remove(kNoPlanSelectedError);
                        });
                      },
                    );
                  },
                );
              }
              if (plansstate is PlansFetchingFailed) {
                return SizedBox(
                  height: getProportionateScreenHeight(120),
                  child: Center(
                    child: Text(
                      'Plans fetching faied',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
        Spacer(),
        BlocListener<PaymentBloc, PaymentState>(
          listener: (context, paymentstate) {
            if (paymentstate is PaymentCompleted) {
              if (paymentstate.errorCode == "00001") {
                errors.remove(kwrongCodeError);
                BlocProvider.of<PaymentBloc>(context).add(
                  FinishPaymentAndRegister(
                    subscriptionTypeId: subscriptions[selectedPlan!].id,
                  ),
                );
                widget.onPress();
              } else {
                if (!errors.contains(kwrongCodeError))
                  errors.add(kwrongCodeError);
              }
            }
            if (paymentstate is PaymentFailed) {
              setState(() {
                if (!errors.contains(kOtpError)) errors.add(kOtpError);
              });
            }
          },
          child: SizedBox(
            height: getProportionateScreenHeight(40),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (selectedPlan == null &&
                    !errors.contains(kNoPlanSelectedError)) {
                  setState(() {
                    errors.add(kNoPlanSelectedError);
                  });
                } else if (selectedPlan != null &&
                    _formKey.currentState!.validate()) {
                  BlocProvider.of<PaymentBloc>(context).add(
                    CommitPayment(
                      phoneNumber: widget.phoneNumber,
                      pin: textFieldController.text,
                      amount: subscriptions[selectedPlan!].fee,
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
        ),
        verticalSpacing(10),
      ],
    );
  }
}
