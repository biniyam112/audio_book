import 'package:audio_books/constants.dart';
import 'package:audio_books/feature/fetch_infinite_books/bloc/fetch_infinite_books_bloc.dart';
import 'package:audio_books/feature/fetch_infinite_books/bloc/fetch_infinite_books_event.dart';
import 'package:audio_books/feature/fetch_infinite_books/bloc/fetch_infinite_books_state.dart';
import 'package:audio_books/models/category.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'components/infinite_book_tile.dart';

class InfiniteBooksList extends StatelessWidget {
  const InfiniteBooksList({
    Key? key,
    required this.title,
    this.category,
    this.author,
  }) : super(key: key);
  final String title;
  final Category? category;
  final Author? author;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '$title',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Body(
        author: author,
        category: category,
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
    this.category,
    this.author,
  }) : super(key: key);
  final Category? category;
  final Author? author;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    BlocProvider.of<FetchInfiniteBooksBloc>(context).add(ClearBlocState());

    if (widget.category != null)
      BlocProvider.of<FetchInfiniteBooksBloc>(context).add(
        FetchInfiniteBooksEvent(
          infiniteItemType: InfiniteItemType.bookCategory,
          itemId: widget.category!.id,
        ),
      );
    if (widget.author != null)
      BlocProvider.of<FetchInfiniteBooksBloc>(context).add(
        FetchInfiniteBooksEvent(
          infiniteItemType: InfiniteItemType.author,
          itemId: widget.author!.id,
        ),
      );
    super.initState();
  }

  void _onScroll() {
    if (_isBottom) {
      if (widget.category != null)
        BlocProvider.of<FetchInfiniteBooksBloc>(context).add(
          FetchInfiniteBooksEvent(
            infiniteItemType: InfiniteItemType.bookCategory,
            itemId: widget.category!.id,
          ),
        );
      if (widget.author != null)
        BlocProvider.of<FetchInfiniteBooksBloc>(context).add(
          FetchInfiniteBooksEvent(
            infiniteItemType: InfiniteItemType.author,
            itemId: widget.author!.id,
          ),
        );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: BlocBuilder<FetchInfiniteBooksBloc, InfiniteBooksState>(
        builder: (context, state) {
          switch (state.status) {
            case FetchingStatus.failed:
              return Center(
                child: Text(
                  kInfiniteListFetchingError,
                  style: Theme.of(context).textTheme.headline4,
                ),
              );
            case FetchingStatus.initial:
              return Center(
                child: CircularProgressIndicator(
                  color: Darktheme.primaryColor,
                ),
              );

            case FetchingStatus.success:
              if (state.books.isEmpty)
                return Center(
                  child: Text(
                    'No items available',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .9,
                ),
                itemCount: state.hasReachedLimit
                    ? state.books.length
                    : state.books.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.books.length
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Darktheme.primaryColor,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8),
                          child: InfiniteBookTile(book: state.books[index]),
                        );
                },
              );
          }
        },
      ),
    );
  }
}
