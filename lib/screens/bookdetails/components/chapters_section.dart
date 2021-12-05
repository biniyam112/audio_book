import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_bloc.dart';
import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_event.dart';
import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_state.dart';
import 'package:audio_books/feature/payment/bloc/payment_bloc.dart';
import 'package:audio_books/feature/payment/bloc/payment_event.dart';
import 'package:audio_books/feature/payment/bloc/payment_state.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../sizeConfig.dart';
import 'chapter_tile.dart';

class ChaptersSection extends StatelessWidget {
  const ChaptersSection({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (SizeConfig.screenHeight! / 2),
      width: SizeConfig.screenWidth,
      child: RefreshIndicator(
        color: Darktheme.primaryColor,
        onRefresh: () async {
          BlocProvider.of<FetchChaptersBloc>(context)
              .add(FetchChaptersEvent(book: book));
          BlocProvider.of<PaymentBloc>(context)
              .add(CheckSubscription(isEbook: false));
        },
        child: SingleChildScrollView(
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, paymentstate) {
              if (paymentstate is CheckSubOnprocess) {
                return SizedBox(
                  height: SizeConfig.screenHeight! * .3,
                  width: SizeConfig.screenWidth,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Darktheme.primaryColor,
                    ),
                  ),
                );
              }

              if (paymentstate is CheckSubCompleted) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<FetchChaptersBloc, FetchChaptersState>(
                        builder: (blocontext, state) {
                      if (state is ChaptersFetchedState) {
                        print(
                            'the chapters fetched are : ${state.chapters.length}');
                        if (state.chapters.isEmpty)
                          return SizedBox(
                            height: SizeConfig.screenHeight! * .3,
                            width: SizeConfig.screenWidth,
                            child: Center(
                              child: Text(
                                'No items avilable',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          );
                        return Column(
                          children: [
                            ...List.generate(
                              state.chapters.length,
                              (index) => EpisodeTile(
                                book: book,
                                isPaidFor:
                                    paymentstate.subscribtions.isNotEmpty ||
                                        book.priceEtb == 0,
                                episode: state.chapters[index],
                                chapterNumber: index + 1,
                              ),
                            ),
                          ],
                        );
                      }
                      if (state is ChaptersFetchingState) {
                        return SizedBox(
                          height: SizeConfig.screenHeight! * .3,
                          width: SizeConfig.screenWidth,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Darktheme.primaryColor,
                            ),
                          ),
                        );
                      }
                      if (state is ChaptersFetchingFailedState) {
                        return SizedBox(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight! * .4,
                          child: Center(
                            child: Opacity(
                              opacity: .8,
                              child: Text(
                                'Unable to fetch chapters',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ),
                        );
                      }
                      return Text('Unstable reality');
                    }),
                  ],
                );
              }
              if (paymentstate is CheckSubFailed) {
                return Center(
                  child: Text('unable to fetch items,\n Try again!'),
                );
              }
              return Container(
                height: SizeConfig.screenHeight! * .4,
                width: SizeConfig.screenWidth,
                child: Center(
                  child: Text('unstable reality'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
