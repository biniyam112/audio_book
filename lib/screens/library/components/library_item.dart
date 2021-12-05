import 'dart:io';
import 'dart:typed_data';
import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/screens/bookchapters/book_chapters.dart';
import 'package:audio_books/screens/pdfviewer/pdf_viewer_screen.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class EBookLibraryItem extends StatelessWidget {
  final DownloadedBook downloadedBook;

  Future<Uint8List> fetchCoverImage({required String imagePath}) async {
    File file = File(imagePath);
    final byteImage = file.readAsBytes();
    return byteImage;
  }

  const EBookLibraryItem({required this.downloadedBook, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return InkWell(
      onTap: () {
        pushNewScreen(
          context,
          screen: PdfViewerScreen(downloadedBook: downloadedBook),
          withNavBar: false,
        );
      },
      child: Neumorphic(
        style: NeumorphicStyle(
          color: isDarkMode ? Darktheme.backgroundColor : Colors.white,
          shadowLightColor: LightTheme.shadowColor.withOpacity(.3),
          shadowDarkColor: Darktheme.shadowColor.withOpacity(.5),
          intensity: 1,
          lightSource: LightSource.top,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: isDarkMode ? Darktheme.containerColor : Colors.white,
              height: getProportionateScreenHeight(160),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(0),
                ),
                child: FutureBuilder<Uint8List>(
                    future: fetchCoverImage(
                        imagePath: downloadedBook.coverArtPath!),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Darktheme.primaryColor,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      }
                    }),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    downloadedBook.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: getProportionateScreenHeight(15)),
                  ),
                  verticalSpacing(2),
                  Text(
                    "By ${downloadedBook.author}",
                    style: TextStyle(
                      color: isDarkMode ? Colors.white60 : Colors.grey.shade600,
                    ),
                  ),
                  verticalSpacing(10),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(2),
                          horizontal: getProportionateScreenWidth(5)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: (downloadedBook.percentCompleted),
                          color: Darktheme.primaryColor,
                          backgroundColor:
                              Darktheme.shadowColor.withOpacity(.4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class AudioBookLibraryItem extends StatelessWidget {
  final DownloadedBook downloadedBook;

  Future<Uint8List> fetchCoverImage({required String imagePath}) async {
    File file = File(imagePath);
    final byteImage = file.readAsBytes();
    return byteImage;
  }

  const AudioBookLibraryItem({required this.downloadedBook, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return InkWell(
      onTap: () {
        pushNewScreen(
          context,
          screen: BookEpisodes(
            downloadedBook: downloadedBook,
          ),
          withNavBar: false,
        );
      },
      child: Neumorphic(
        style: NeumorphicStyle(
          color: isDarkMode ? Darktheme.backgroundColor : Colors.white,
          shadowLightColor: LightTheme.shadowColor.withOpacity(.3),
          shadowDarkColor: Darktheme.shadowColor.withOpacity(.5),
          intensity: 1,
          lightSource: LightSource.top,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: isDarkMode ? Darktheme.containerColor : Colors.white,
              height: getProportionateScreenHeight(160),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(0),
                ),
                child: FutureBuilder<Uint8List>(
                    future: fetchCoverImage(
                        imagePath: downloadedBook.coverArtPath!),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Darktheme.primaryColor,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      }
                    }),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    downloadedBook.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: getProportionateScreenHeight(15)),
                  ),
                  verticalSpacing(2),
                  Text(
                    "By ${downloadedBook.author}",
                    style: TextStyle(
                      color: isDarkMode ? Colors.white60 : Colors.grey.shade600,
                    ),
                  ),
                  verticalSpacing(6),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(2),
                          horizontal: getProportionateScreenWidth(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bookmark,
                            color: Darktheme.primaryColor,
                          ),
                          horizontalSpacing(4),
                          Text('${downloadedBook.category}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
