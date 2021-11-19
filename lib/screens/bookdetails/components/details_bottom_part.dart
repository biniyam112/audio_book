import 'package:audio_books/models/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../sizeConfig.dart';
import 'custom_tab_view_children.dart';
import 'text_with_custom_underline.dart';

class DetailsBottomPart extends StatefulWidget {
  const DetailsBottomPart({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  _DetailsBottomPartState createState() => _DetailsBottomPartState();
}

class _DetailsBottomPartState extends State<DetailsBottomPart> {
  int activeContextIndex = 0;
  late PageController pageViewController;

  @override
  void initState() {
    super.initState();
    pageViewController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWithCustomUnderline(
                      title: 'Preface',
                      onTap: () {
                        activeContextIndex = 0;
                        pageViewController.jumpToPage(0);
                      },
                      isActive: activeContextIndex == 0,
                    ),
                    Spacer(),
                    TextWithCustomUnderline(
                      title: 'Chapters',
                      onTap: () {
                        activeContextIndex = 1;
                        pageViewController.jumpToPage(1);
                      },
                      isActive: activeContextIndex == 1,
                    ),
                    Spacer(),
                    TextWithCustomUnderline(
                      title: 'Comments',
                      onTap: () {
                        activeContextIndex = 2;
                        pageViewController.jumpToPage(2);
                      },
                      isActive: activeContextIndex == 2,
                    ),
                    Spacer(flex: 2),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(16)),
                Container(
                  height: SizeConfig.screenHeight! * .405,
                  child: PageView(
                    controller: pageViewController,
                    onPageChanged: (index) {
                      setState(() {
                        activeContextIndex = index;
                      });
                    },
                    children: [
                      ...List.generate(
                        3,
                        (index) {
                          return CustomTabViewChildren(
                            index: index,
                            book: widget.book,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
