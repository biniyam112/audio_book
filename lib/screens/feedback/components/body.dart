import 'package:audio_books/constants.dart';
import 'package:audio_books/feature/feedback/bloc/feedback_bloc.dart';
import 'package:audio_books/models/feedback.dart' as userFeedback;
import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/screens/screens.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _controller = TextEditingController();
  List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    var isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Padding(
      padding: const EdgeInsets.all(34),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isDarkMode
                  ? Darktheme.containerColor
                  : LightTheme.backgroundColor,
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MARAKI,',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                      ),
                ),
                verticalSpacing(8),
                Opacity(
                  opacity: .8,
                  child: Text(
                    'give feedback about our app here. we will consider thi sto improve the app',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),
          ),
          verticalSpacing(32),
          InputFieldContainer(
            title: 'Feedback',
            spacing: 6,
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'feedback',
              ),
            ),
          ),
          verticalSpacing(20),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_controller.text.isEmpty) {
                  setState(() {
                    return errors.add(kFeedbackEmptyError);
                  });
                }
                BlocProvider.of<FeedbackBloc>(context).add(
                  SubmitFeedback(
                    feedback: userFeedback.Feedback(
                      content: _controller.text,
                    ),
                  ),
                );
              },
              child: Text(
                'Submit',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          verticalSpacing(10),
          FormError(errors: errors),
        ],
      ),
    );
  }
}
