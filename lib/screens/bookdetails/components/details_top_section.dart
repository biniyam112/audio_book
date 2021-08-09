import 'package:audio_books/feature/store_book/bloc/store_book_bloc.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_event.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_state.dart';
import 'package:audio_books/models/book.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/bookdetails/components/purchase_button.dart';
import 'package:audio_books/screens/bookdetails/components/rating_display.dart';
import 'package:audio_books/screens/pdfviewer/pdf_viewer_screen.dart';
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
                PurchaseButton(
                  text: 'Get E-book',
                  onPress: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                          width: SizeConfig.screenWidth,
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          child: Text('Download started '),
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    BlocProvider.of<StoreBookBloc>(context)
                        .add(StoreBookEvent(book));
                    BlocListener<StoreBookBloc, StoreBookState>(
                      listener: (context, state) {
                        print('I\'m working');
                        if (state is StoringBookState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                width: SizeConfig.screenWidth,
                                padding: EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Text('Downloading... '),
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                        if (state is BookStoredState) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PdfViewerScreen(
                                  downloadedBook: state.downloadedBook,
                                );
                              },
                            ),
                          );
                        }
                        if (state is StoringBookFailedState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                width: SizeConfig.screenWidth,
                                padding: EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Text('Failed to fetch item '),
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    );
                  },
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: '${book.coverArt}',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          height: SizeConfig.screenHeight! * .3,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
