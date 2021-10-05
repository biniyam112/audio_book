import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.downloadedBook}) : super(key: key);
  final DownloadedBook downloadedBook;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                10,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Container();
                            // return AudioPlayerScreen(
                            //   book: libraryMockData[index],
                            // );
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: SizeConfig.screenWidth,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                downloadedBook.title,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              Text(
                                'Chapter ${index + 1}',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(
                            CupertinoIcons.right_chevron,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
