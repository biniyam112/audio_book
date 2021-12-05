import 'package:audio_books/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chapters_section.dart';
import 'comment_section.dart';
import 'preface_section.dart';

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
      return PrefaceSection(book: book);
    }
    if (index == 1) {
      return ChaptersSection(book: book);
    }
    if (index == 2) {
      return CommentSection(book: book);
    } else {
      return Text('unstale reality');
    }
  }
}
