import 'package:audio_books/feature/store_book/bloc/store_book_bloc.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_event.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_state.dart';
import 'package:audio_books/models/book.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/bookdetails/components/purchase_button.dart';
import 'package:audio_books/screens/bookdetails/components/rating_display.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';
import 'book_genere_card.dart';
import 'downloads_count.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocListener<StoreBookBloc, StoreBookState>(
                  listener: (context, state) {
                    if (state is StoringBookState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        buildSnackBar(context, text: 'Downloading... '),
                      );
                    }
                    if (state is BookStoredState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        buildSnackBar(context, text: 'Book added to library'),
                      );
                    }
                    if (state is StoringBookFailedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        buildSnackBar(context, text: 'Failed to fetch item'),
                      );
                    }
                  },
                  child: PurchaseButton(
                    text: 'Get E-book',
                    onPress: () {
                      BlocProvider.of<StoreBookBloc>(context)
                          .add(StoreBookEvent(book));
                    },
                  ),
                ),
                PurchaseButton(
                  text: 'Get Audio book',
                  onPress: () {},
                ),
              ],
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
        RatingDisplay(ratingValue: 4.6),
        DownloadsCounter(downloadCount: 87),
      ],
    );
  }
}

class TopDetailsImageSection extends StatelessWidget {
  const TopDetailsImageSection({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth! * .43,
      child: Hero(
        tag: book.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: '${book.coverArt}',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: Container(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress))),
            errorWidget: (context, url, error) => Icon(Icons.error),
            height: SizeConfig.screenHeight! * .3,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
