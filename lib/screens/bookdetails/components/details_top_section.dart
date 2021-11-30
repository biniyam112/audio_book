import 'package:audio_books/feature/payment/bloc/payment_bloc.dart';
import 'package:audio_books/feature/payment/bloc/payment_event.dart';
import 'package:audio_books/feature/payment/bloc/payment_state.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_bloc.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_event.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_state.dart';
import 'package:audio_books/models/book.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/bookdetails/components/get_books_madal_view.dart';
import 'package:audio_books/screens/bookdetails/components/purchase_button.dart';
import 'package:audio_books/screens/bookdetails/components/author_display.dart';
import 'package:audio_books/screens/paymentModal/payment_modal_card.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';
import 'book_genere_card.dart';
import 'details_bottom_part.dart';

class DetailsTopSection extends StatelessWidget {
  const DetailsTopSection({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      height: SizeConfig.screenHeight! * .4,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TopDetailsImageSection(book: book),
                  ),
                  horizontalSpacing(16),
                  Expanded(
                    child: TopDetailsRightSection(
                      book: book,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacing(10),
            BlocConsumer<PaymentBloc, PaymentState>(
              builder: (context, checksubstate) {
                return BlocConsumer<StoreBookBloc, StoreBookState>(
                  listener: (context, storingstate) {
                    if (storingstate is BookStoringState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        buildSnackBar(context, text: 'Downloading... '),
                      );
                    }
                    if (storingstate is BookStoredState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        buildSnackBar(context, text: 'Book added to library'),
                      );
                    }
                    if (storingstate is BookStoringFailedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        buildSnackBar(context, text: 'Failed to fetch item'),
                      );
                    }
                  },
                  builder: (context, storingstate) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PurchaseButton(
                          text: 'Get E-book',
                          onPress: (book.resourceType == 'Ebook' ||
                                  book.resourceType == 'Both')
                              ? () {
                                  if (book.priceEtb! == 0) {
                                    BlocProvider.of<StoreBookBloc>(context)
                                        .add(StoreEBookEvent(book: book));
                                  } else {
                                    BlocProvider.of<PaymentBloc>(context)
                                        .add(CheckSubscription(isEbook: true));
                                  }
                                }
                              : null,
                        ),
                        PurchaseButton(
                          text: 'Get Audio book',
                          onPress: (book.resourceType == 'AudioBook' ||
                                  book.resourceType == 'Both')
                              ? () {
                                  BlocProvider.of<PaymentBloc>(context)
                                      .add(CheckSubscription(isEbook: false));
                                }
                              : null,
                        ),
                      ],
                    );
                  },
                );
              },

              // ? If subsiripiton plan is available start downloading app
              listener: (context, checksubstate) {
                if (checksubstate is CheckSubCompleted) {
                  if (checksubstate.subscribtions.isEmpty) {
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
                  if (checksubstate.subscribtions.isNotEmpty &&
                      checksubstate.isEbook) {
                    BlocProvider.of<StoreBookBloc>(context)
                        .add(StoreEBookEvent(book: book));
                  }
                  if (checksubstate.subscribtions.isNotEmpty &&
                      !checksubstate.isEbook) {
                    DetailsBottomPartState.tabController.animateTo(1);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  SnackBar buildSnackBar(
    BuildContext context, {
    required String text,
  }) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return SnackBar(
      elevation: 6,
      backgroundColor: isDarkMode ? Darktheme.backgroundColor : Colors.white,
      content: Container(
        width: SizeConfig.screenWidth,
        child: Text(
          '$text',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      duration: Duration(seconds: 2),
    );
  }
}

class TopDetailsRightSection extends StatelessWidget {
  const TopDetailsRightSection({
    Key? key,
    required this.book,
    required this.isDarkMode,
  }) : super(key: key);

  final Book book;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${book.title}',
          maxLines: 2,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 6),
        RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: isDarkMode ? Colors.white70 : Colors.black45,
                ),
            children: [
              TextSpan(text: 'Author  '),
              TextSpan(text: '${book.author}'),
            ],
          ),
        ),
        RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: isDarkMode ? Colors.white70 : Colors.black45,
                ),
            children: [
              TextSpan(text: 'Narattor  '),
              TextSpan(text: '${book.narattor}'),
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(6)),
        BookGenereCard(
          genere: '#${book.category}',
        ),
        verticalSpacing(6),
        AuthorDisplay(
          authorName: book.author,
        ),
        verticalSpacing(6),
        Container(
          color: Colors.transparent,
          child: TextButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                builder: (context) {
                  return GetHardCopy(book: book);
                },
              );
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(6)),
            ),
            child: Text(
              'Get Hard Copy',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[850],
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class TopDetailsImageSection extends StatefulWidget {
  const TopDetailsImageSection({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  _TopDetailsImageSectionState createState() => _TopDetailsImageSectionState();
}

class _TopDetailsImageSectionState extends State<TopDetailsImageSection> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.book.id,
      child: Container(
        width: SizeConfig.screenWidth! * .43,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: widget.book.coverArt,
            placeholder: (context, message) => Center(
              child: Container(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
