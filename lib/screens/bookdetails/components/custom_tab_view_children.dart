import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_bloc.dart';
import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_state.dart';
import 'package:audio_books/feature/request_hard_copy/bloc/request_hard_copy_bloc.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../sizeConfig.dart';
import 'chapter_tile.dart';

class CustomTabViewChildren extends StatelessWidget {
  const CustomTabViewChildren({
    Key? key,
    required this.index,
    required this.book,
  }) : super(key: key);

  final int index;
  final Book book;

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Opacity(
          opacity: .8,
          child: Text(
            book.description,
            maxLines: 20,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  height: 1.5,
                ),
          ),
        ),
      );
    }
    if (index == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<FetchChaptersBloc, FetchChaptersState>(
              builder: (blocontext, state) {
            if (state is ChaptersFetchedState) {
              if (state.chapters.isEmpty)
                return SizedBox(
                  height: SizeConfig.screenHeight! * .36,
                  child: Center(
                    child: Text(
                      'No items avilable',
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
                      episode: state.chapters[index],
                      chapterNumber: index + 1,
                    ),
                  ),
                ],
              );
            }
            if (state is ChaptersFetchingState) {
              return Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  color: Darktheme.primaryColor,
                ),
              );
            }
            if (state is ChaptersFetchingFailedState) {
              return Padding(
                padding: EdgeInsets.only(top: getProportionateScreenHeight(20)),
                child: Opacity(
                  opacity: .8,
                  child: Text(
                    'Unable to fetch chapters',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              );
            }
            return Text('Unstable reality');
          }),
        ],
      );
    }
    if (index == 2) {
      return BlocProvider(
        create: (context) => CounterCubit(CounterState(counter: 1)),
        child: BlocBuilder<CounterCubit, CounterState>(
          builder: (context, counterState) {
            return BlocBuilder<RequestHardBookBloc, RequestHardCopyState>(
              builder: (context, copystate) {
                return Container(
                  height: SizeConfig.screenHeight! * .4,
                  width: SizeConfig.screenWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpacing(10),
                      Text(
                        'Number of copies',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      verticalSpacing(12),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PlusButton(),
                          Container(
                            height: 40,
                            constraints:
                                BoxConstraints(maxWidth: 50, minWidth: 42),
                            alignment: Alignment.center,
                            child: Text(
                              '${counterState.counter}',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                          MinusButton(),
                        ],
                      ),
                      Spacer(),
                      if (copystate == RequestHardCopyState.idleState)
                        Center(
                          child: Opacity(
                            opacity: .8,
                            child: SizedBox(
                              width: SizeConfig.screenWidth! / 1.5,
                              child: Text(
                                'Request the book\'s hard copy.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ),
                        ),
                      if (copystate ==
                          RequestHardCopyState.requestHardcopySubmiting)
                        Center(
                          child: SizedBox(
                            height: 32,
                            width: 32,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Darktheme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      if (copystate ==
                          RequestHardCopyState.requestHardcopySubmissionFailed)
                        Center(
                          child: Opacity(
                            opacity: .8,
                            child: Text(
                              'Request failed try again',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ),
                      if (copystate ==
                          RequestHardCopyState.requestHardcopySubmitted)
                        Center(
                          child: Opacity(
                            opacity: .8,
                            child: SizedBox(
                              width: SizeConfig.screenWidth! / 1.5,
                              child: Text(
                                'Your request have been succesfuly submitted',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      Spacer(flex: 2),
                      SizedBox(
                        height: 50,
                        width: SizeConfig.screenWidth! - 30,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: counterState.submitted
                              ? null
                              : () {
                                  context.read<CounterCubit>().submit();
                                  BlocProvider.of<RequestHardBookBloc>(context)
                                      .add(
                                    RequestHardCopyEvent(
                                      book: book,
                                      numberOfCopies: counterState.counter,
                                    ),
                                  );
                                },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            child: Text(
                              'Request ${counterState.counter} hard cop${(counterState.counter == 1) ? 'y' : 'ies'}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}

class PlusButton extends StatelessWidget {
  const PlusButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Darktheme.primaryColor.withOpacity(.85),
      ),
      child: InkWell(
        splashColor: Darktheme.primaryColor,
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          context.read<CounterCubit>().increment();
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            CupertinoIcons.add,
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MinusButton extends StatelessWidget {
  const MinusButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Darktheme.primaryColor.withOpacity(.85),
      ),
      child: InkWell(
        splashColor: Darktheme.primaryColor,
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          context.read<CounterCubit>().decrement();
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            CupertinoIcons.minus,
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CounterCubit extends Cubit<CounterState> {
  CounterCubit(CounterState initialState) : super(initialState);
  void increment() => emit(CounterState(counter: state.counter + 1));
  void decrement() {
    if (state.counter > 1) emit(CounterState(counter: state.counter - 1));
  }

  void submit() => emit(CounterState(counter: state.counter, submitted: true));
}

class CounterState {
  int counter;
  bool submitted;
  CounterState({required this.counter, this.submitted = false});
}
