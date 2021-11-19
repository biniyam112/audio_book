import 'package:audio_books/feature/payment/bloc/payment_bloc.dart';
import 'package:audio_books/feature/payment/bloc/payment_event.dart';
import 'package:audio_books/feature/payment/bloc/payment_state.dart';
import 'package:audio_books/models/subscription.dart';
import 'package:audio_books/screens/paymentModal/subscribtion_modal_card.dart';
import 'package:audio_books/screens/settings/components/settings_bottom.dart';
import 'package:audio_books/screens/settings/components/subscription_card.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionSetting extends StatelessWidget {
  const SubscriptionSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "SUBSCRIPTION_SETTING CONTENT*************************${PaymentBloc.subscriptionPlans}");

    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        print("SUBSCRIPTION_PLAN STATE*********************$state");
        if (state is PlansFetchingFailed) {
          BlocProvider.of<PaymentBloc>(context).add(FetchPlans());
        }
        if (state is CheckSubFailed) {
          BlocProvider.of<PaymentBloc>(context)
              .add(CheckSubscription(isEbook: false));
        }
      },
      builder: (context, state) {
        return state is PlansFetching || state is CheckSubOnprocess
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              )
            : state is PlansFetchingFailed || state is CheckSubFailed
                ? Center(
                    child: Text("Failed to fetch subscription plans"),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Subscription Plan",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade600),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      ...List.generate(
                        PaymentBloc.subscriptionPlans.length,
                        (index) {
                          return Column(
                            children: [
                              SubscriptionCard(
                                  subscribtion:
                                      PaymentBloc.subscriptionPlans[index]),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      SettingsBottom()
                    ],
                  );
      },
    );
  }
}
