import 'package:audio_books/feature/payment/bloc/payment_bloc.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/paymentModal/payment_modal_card.dart';
import 'package:audio_books/services/helper_method.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({Key? key, required this.subscribtion})
      : super(key: key);

  final Subscribtion subscribtion;

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return GestureDetector(
      onTap: () {
        if (PaymentBloc.userSubscriptions.length == 0) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            builder: (context) {
              return PaymentModalCard();
            },
          );
        }
      },
      child: Neumorphic(
        style: NeumorphicStyle(
          color: Colors.grey.shade300,
          shadowLightColor: LightTheme.shadowColor.withOpacity(.3),
          shadowDarkColor: Darktheme.shadowColor.withOpacity(.5),
          intensity: 1,
          depth: 1,
          shape: NeumorphicShape.flat,
          lightSource: LightSource.top,
        ),
        child: Container(
          width: double.infinity,
          color: isDarkMode
              ? Darktheme.containerColor
              : LightTheme.backgroundColor,
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(9)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    RichText(
                        text: TextSpan(children: <WidgetSpan>[
                      WidgetSpan(
                          child: Text(
                        "Maraki",
                        style: Theme.of(context).textTheme.headline3,
                      )),
                      WidgetSpan(
                          child:
                              SizedBox(width: getProportionateScreenHeight(5))),
                      WidgetSpan(
                          child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(1),
                            horizontal: getProportionateScreenWidth(4)),
                        margin: EdgeInsets.only(
                            bottom: getProportionateScreenHeight(7)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: subscribtion.name == 'Monthly' && !isDarkMode
                                ? Colors.black
                                : subscribtion.name == 'Monthly' && isDarkMode
                                    ? Colors.white
                                    : Colors.orange),
                        child: Text(
                          subscribtion.name.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: !isDarkMode ? Colors.white : Colors.black,
                              fontSize: 10),
                        ),
                      ))
                    ])),
                    Text(
                      '${subscribtion.description}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          height: .8),
                    )
                  ],
                ),
              ),
              checkSubscribtion(subscribtion)
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.blue.shade700,
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 15,
                          )),
                    )
                  : Container(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(74)),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
