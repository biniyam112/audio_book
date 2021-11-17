import 'package:audio_books/feature/author/bloc/author_bloc.dart';
import 'package:audio_books/feature/author/bloc/author_state.dart';
import 'package:audio_books/screens/categoryallbooks/category_all_books.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthorDisplay extends StatelessWidget {
  const AuthorDisplay({
    Key? key,
    required this.authorName,
  }) : super(key: key);
  final String authorName;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return BlocBuilder<AuthorBloc, AuthorState>(
      builder: (blocContext, authorState) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CategoryAllBooks(category: '$authorName');
                },
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (authorState is AuthorsFetchedState)
                CircleAvatar(
                  radius: 30,
                  foregroundImage: CachedNetworkImageProvider(
                    '${authorState.author.authorImage}',
                  ),
                ),
              if (authorState is AuthorsFetchingFailedState)
                Container(
                  height: 60,
                  width: 60,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Darktheme.shadowColor.withOpacity(.071),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/User Icon.svg',
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              if (authorState is AuthorsFetchingState)
                Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Darktheme.primaryColor,
                      strokeWidth: 3,
                    ),
                  ),
                ),
              horizontalSpacing(12),
              Opacity(
                opacity: .7,
                child: Text(
                  '$authorName'.replaceAll(' ', '\n'),
                  maxLines: 2,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black87,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
