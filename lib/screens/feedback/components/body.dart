import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDarkMode
                ? Darktheme.containerColor
                : LightTheme.backgroundColor,
          ),
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'MARAKI,',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                    ),
              ),
              Opacity(
                opacity: .8,
                child: Text(
                  'Ad qui enim mollit duis anim duis dolor reprehenderit esse consectetur sunt eiusmod magna officia. Qui ea nisi enim commodo sit anim id eiusmod ullamco non. Nulla excepteur minim nulla minim est ut elit veniam nulla laboris. Fugiat dolore anim incididunt eu ex officia proident velit non cillum incididunt pariatur duis Lorem.',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
