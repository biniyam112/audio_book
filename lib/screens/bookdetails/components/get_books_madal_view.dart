import 'package:audio_books/feature/request_hard_copy/bloc/request_hard_copy_bloc.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/bookdetails/components/author_display.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../sizeConfig.dart';

class GetHardCopy extends StatelessWidget {
  const GetHardCopy({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(CounterState(counter: 1)),
      child: BlocBuilder<CounterCubit, CounterState>(
        builder: (context, counterState) {
          return BlocConsumer<RequestHardBookBloc, RequestHardCopyState>(
            listener: (context, copystate) {
              if (copystate == RequestHardCopyState.requestHardcopySubmitted) {
                context.read<CounterCubit>().reset();
              }
            },
            builder: (context, copystate) {
              return Container(
                height: SizeConfig.screenHeight! * .6,
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Request hard copy',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black.withOpacity(.85)),
                        ),
                        Spacer(),
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            shape: MaterialStateProperty.all(
                              CircleBorder(),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child: Icon(
                              Icons.cancel,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpacing(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: SizeConfig.screenWidth! * .4,
                          width: SizeConfig.screenWidth! * .3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: book.coverArt,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        horizontalSpacing(14),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Opacity(
                                opacity: .9,
                                child: Text(
                                  '${book.title}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                ),
                              ),
                              verticalSpacing(10),
                              Text(
                                '${book.description}',
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      height: 1.5,
                                      color: Colors.black87,
                                    ),
                              ),
                              verticalSpacing(10),
                              AuthorDisplay(
                                authorName: book.author,
                                radius: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpacing(20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MinusButton(),
                          Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: Text(
                              '${counterState.counter} Book${(counterState.counter == 1) ? '' : 's'}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    fontSize: 20,
                                    color: Colors.blueGrey[800],
                                  ),
                            ),
                          ),
                          PlusButton(),
                        ],
                      ),
                    ),
                    Spacer(),
                    if (copystate == RequestHardCopyState.idleState)
                      Center(
                        child: Opacity(
                          opacity: .6,
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
                          opacity: .6,
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
                          opacity: .6,
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
                    Spacer(),
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
                            'Request ${counterState.counter} Book${(counterState.counter == 1) ? '' : 's'}',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
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

  void reset() => emit(CounterState(counter: 1));

  void submit() => emit(CounterState(counter: state.counter, submitted: true));
}

class CounterState {
  int counter;
  bool submitted;
  CounterState({required this.counter, this.submitted = false});
}
