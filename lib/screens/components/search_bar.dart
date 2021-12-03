import 'package:audio_books/feature/search_downloaded_books/bloc/search_downloaded_book_bloc.dart';
import 'package:audio_books/feature/search_downloaded_books/bloc/search_downloaded_books_event.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../screens.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _visibilityNotifier = ValueNotifier<bool>(false);
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _visibilityNotifier.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      height: getProportionateScreenHeight(58),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(30),
      ),
      child: Neumorphic(
        style: NeumorphicStyle(
          intensity: 1,
          lightSource: LightSource.topLeft,
          shadowDarkColor: LightTheme.shadowColor.withOpacity(.3),
          shadowLightColor: LightTheme.shadowColor.withOpacity(.3),
        ),
        child: TextField(
            cursorColor: isDarkMode ? Colors.white : Colors.grey,
            controller: _controller,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 20,
              color: isDarkMode ? Darktheme.textColor : LightTheme.textColor,
            ),
            onChanged: (value) {
              value.length == 0
                  ? _visibilityNotifier.value = false
                  : _visibilityNotifier.value = true;
              if (LibraryBodyState.libraryTabController.index == 0) {
                BlocProvider.of<SearchDownloadedBookBloc>(context).add(
                  SearchDownloadedBookEvent(
                    bookType: BookType.eBook,
                    searchQuery: value,
                  ),
                );
              }
              if (LibraryBodyState.libraryTabController.index == 1) {
                BlocProvider.of<SearchDownloadedBookBloc>(context).add(
                  SearchDownloadedBookEvent(
                    bookType: BookType.audioBook,
                    searchQuery: value,
                  ),
                );
              }
            },
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: isDarkMode ? Colors.white : Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(14),
              ),
              focusColor: Colors.orange,
              suffixIcon: ValueListenableBuilder(
                valueListenable: _visibilityNotifier,
                builder: (_, bool value, __) => Visibility(
                  visible: value,
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.orange,
                    ),
                    onPressed: () => {
                      _controller.value = TextEditingValue.empty,
                      _visibilityNotifier.value = false,
                      BlocProvider.of<SearchDownloadedBookBloc>(context).add(
                        SearchDownloadedBookEvent(
                          bookType: BookType.eBook,
                          searchQuery: '',
                        ),
                      ),
                    },
                  ),
                ),
              ),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDarkMode ? Colors.white60 : Colors.black45,
                  ),
              filled: true,
              fillColor: isDarkMode ? Color(0xff17181D) : Colors.white,
            )),
      ),
    );
  }
}
