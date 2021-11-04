import 'package:audio_books/constants.dart';
import 'package:audio_books/screens/components/page_count_indicator.dart';
import 'package:audio_books/screens/paymentModal/submit_phone_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../sizeConfig.dart';
import 'otp_page.dart';

class PaymentModalCard extends StatefulWidget {
  const PaymentModalCard({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentModalCardState createState() => _PaymentModalCardState();
}

class _PaymentModalCardState extends State<PaymentModalCard> {
  PageController _pageController = PageController();
  int activeIndex = 0;
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight! * .8,
      width: SizeConfig.screenWidth,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/amole_logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      'Amole Payment',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                        shape: MaterialStateProperty.all(
                          CircleBorder(),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpacing(20),
              SizedBox(
                height: SizeConfig.screenHeight! * .6,
                width: SizeConfig.screenWidth,
                child: PageView(
                  reverse: false,
                  physics: NeverScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  onPageChanged: (index) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                  controller: _pageController,
                  children: [
                    SubmitPhonePage(
                      toNextPage: ({required String phoneNumber}) {
                        this.phoneNumber = phoneNumber;
                        _pageController.animateToPage(
                          1,
                          duration: fastDuration,
                          curve: Curves.linear,
                        );
                      },
                    ),
                    OtpPage(
                      phoneNumber: phoneNumber,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    2,
                    (index) => PageCountIndicator(
                      isActive: activeIndex == index,
                      shape: BoxShape.circle,
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
}
