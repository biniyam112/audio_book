import 'package:audio_books/feature/categories/bloc/category_bloc.dart';
import 'package:audio_books/feature/categories/bloc/category_event.dart';
import 'package:audio_books/feature/categories/bloc/category_state.dart';
import 'package:audio_books/feature/featured_books/bloc/featured_books_bloc.dart';
import 'package:audio_books/feature/featured_books/bloc/featured_books_event.dart';
import 'package:audio_books/feature/featured_books/bloc/featured_books_state.dart';
import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_bloc.dart';
import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_event.dart';
import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_state.dart';
import 'package:audio_books/feature/fetch_books_by_category/dataprovider/fetch_by_category_dp.dart';
import 'package:audio_books/feature/fetch_books_by_category/repository/fetch_by_category_repo.dart';
import 'package:audio_books/feature/ping_site/bloc/ping_site_bloc.dart';
import 'package:audio_books/screens/components/no_connection_widget.dart';
import 'package:audio_books/screens/infinite_books_list/infinite_books_list.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'book_category.dart';
import 'book_shelf.dart';
import 'featured_book_tile.dart';

class BooksBody extends StatelessWidget {
  const BooksBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SafeArea(
        child: RefreshIndicator(
          color: Darktheme.primaryColor,
          onRefresh: () async {
            BlocProvider.of<PingSiteBloc>(context).add(
              PingSiteEvent(
                address:
                    'http://www.marakigebeya.com.et/swagger/v1/swagger.json',
              ),
            );
            BlocProvider.of<CategoryBloc>(context).add(FetchCategoryEvent());
            BlocProvider.of<FeaturedBooksBloc>(context)
                .add(FetchFeaturedBooks());
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: BlocBuilder<PingSiteBloc, PingSiteState>(
              builder: (blocContext, pingState) {
                if (pingState == PingSiteState.inProcess) {
                  return SizedBox(
                    height: SizeConfig.screenHeight! * .8,
                    width: SizeConfig.screenWidth,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Darktheme.primaryColor,
                      ),
                    ),
                  );
                }
                if (pingState == PingSiteState.failed) {
                  return NoConnectionWidget();
                }
                if (pingState == PingSiteState.success) {
                  return Column(
                    children: [
                      BlocConsumer<FeaturedBooksBloc, FeaturedBooksState>(
                        listener: (context, state) {
                          if (state is FeaturedBooksFetchingFailed) {
                            BlocProvider.of<PingSiteBloc>(context)
                                .add(PingSiteEvent());
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 12,
                                ),
                                child: BookCategory(
                                  categoryName: 'Featured Books',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => InfiniteBooksList(
                                          title: 'Featured Books',
                                          isFeatured: true,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              if (state is FeaturedBooksFetched)
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ...List.generate(
                                        state.books.length,
                                        (index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  getProportionateScreenWidth(
                                                      8),
                                              vertical: 6,
                                            ),
                                            child: FeaturedBooksTile(
                                              book: state.books[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              if (state is FeaturedBooksFetching)
                                SizedBox(
                                  height: SizeConfig.screenHeight! * .2,
                                  width: SizeConfig.screenWidth,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Darktheme.primaryColor,
                                    ),
                                  ),
                                ),
                              if (state is FeaturedBooksFetchingFailed)
                                SizedBox(
                                  height: SizeConfig.screenHeight! * .2,
                                  width: SizeConfig.screenWidth,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Opacity(
                                          opacity: .9,
                                          child: SvgPicture.asset(
                                            'assets/icons/item_not_found.svg',
                                          ),
                                        ),
                                      ),
                                      verticalSpacing(6),
                                      Opacity(
                                        opacity: .8,
                                        child: Text(
                                          'Something went wrong,\nPlease try again!',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      verticalSpacing(10),
                      BlocConsumer<CategoryBloc, CategoryState>(
                        listener: (context, categoryState) {
                          if (categoryState is CategoriesFetchingFailedState) {
                            BlocProvider.of<CategoryBloc>(context)
                                .add(CategoryEvent());
                          }
                        },
                        builder: (blocContext, categoryState) {
                          if (categoryState is CategoriesFetchedState) {
                            var categories = categoryState.categories;
                            return Column(
                              children: [
                                ...List.generate(
                                  categories.length,
                                  (index) {
                                    return BlocProvider(
                                      create: (context) =>
                                          FetchBooksByCategoryBloc(
                                        fetchBooksByCateRepo:
                                            FetchBooksByCateRepo(
                                          fetchBooksByCateDP:
                                              FetchBooksByCateDP(
                                            client: http.Client(),
                                          ),
                                        ),
                                      )..add(
                                              FetchBooksByCategoryEvent(
                                                category: categories[index],
                                              ),
                                            ),
                                      child: BlocBuilder<
                                          FetchBooksByCategoryBloc,
                                          FetchBooksByCategoryState>(
                                        builder: (context, booksState) {
                                          if (booksState
                                              is CategoryBooksFetchedState) {
                                            var books = booksState.books;
                                            return BookShelf(
                                              categoryName:
                                                  '${categories[index].name}',
                                              books: books,
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        InfiniteBooksList(
                                                      category:
                                                          categories[index],
                                                      title: categories[index]
                                                          .name,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                          if (booksState
                                              is CategoryBooksFetchingState) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 6,
                                                    horizontal: 12,
                                                  ),
                                                  child: BookCategory(
                                                    categoryName:
                                                        '${categories[index].name}',
                                                    onPressed: null,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: SizeConfig
                                                            .screenHeight! *
                                                        .2,
                                                    width: 40,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Darktheme
                                                            .primaryColor,
                                                      ),
                                                    )),
                                              ],
                                            );
                                          }
                                          if (booksState
                                              is CategoryBooksFetchFailedState) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 6,
                                                    horizontal: 12,
                                                  ),
                                                  child: BookCategory(
                                                    categoryName:
                                                        '${categories[index].name}',
                                                    onPressed: null,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      SizeConfig.screenHeight! *
                                                          .2,
                                                  width: SizeConfig.screenWidth,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Opacity(
                                                          opacity: .9,
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/icons/item_not_found.svg',
                                                          ),
                                                        ),
                                                      ),
                                                      verticalSpacing(6),
                                                      Center(
                                                        child: Opacity(
                                                          opacity: .8,
                                                          child: Text(
                                                            'Something went wrong,\nPlease try again!',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5,
                                                          ),
                                                        ),
                                                      ),
                                                      verticalSpacing(20),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                          return SizedBox(
                                            height:
                                                SizeConfig.screenHeight! * .2,
                                            width: SizeConfig.screenWidth,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Opacity(
                                                    opacity: .9,
                                                    child: SvgPicture.asset(
                                                      'assets/icons/item_not_found.svg',
                                                    ),
                                                  ),
                                                ),
                                                verticalSpacing(6),
                                                Center(
                                                  child: Opacity(
                                                    opacity: .8,
                                                    child: Text(
                                                      'Something went wrong,\nPlease try again!',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5,
                                                    ),
                                                  ),
                                                ),
                                                verticalSpacing(20),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          }
                          if (categoryState is CategoriesFetchingState) {
                            return SizedBox(
                              height: SizeConfig.screenHeight! * .2,
                              width: SizeConfig.screenWidth,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Darktheme.primaryColor,
                                ),
                              ),
                            );
                          }
                          if (categoryState is CategoriesFetchingFailedState) {
                            return NoConnectionWidget();
                          }

                          return NoConnectionWidget();
                        },
                      ),
                      verticalSpacing(10),
                    ],
                  );
                }
                return SizedBox(
                  height: SizeConfig.screenHeight! * .2,
                  width: SizeConfig.screenWidth,
                  child: Column(
                    children: [
                      Expanded(
                        child: Opacity(
                          opacity: .9,
                          child: SvgPicture.asset(
                            'assets/icons/item_not_found.svg',
                          ),
                        ),
                      ),
                      verticalSpacing(6),
                      Opacity(
                        opacity: .8,
                        child: Text(
                          'Something went wrong,\nPlease try again!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
