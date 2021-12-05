import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/feature/url_endpoints.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PodcastCommentField extends StatefulWidget {
  const PodcastCommentField({required this.podcastId, Key? key})
      : super(key: key);
  final String podcastId;

  @override
  State<PodcastCommentField> createState() => _PodcastCommentFieldState();
}

class _PodcastCommentFieldState extends State<PodcastCommentField> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PodcastCommentBloc, PodcastCommentState>(
      listener: (context, state) {
        bool isDarkMode =
            Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
        if (state is PodcastCommentSubmittedSuccess) {
          BlocProvider.of<PodcastCommentBloc>(context)
              .add(FetchPodcastComments(podcastId: widget.podcastId));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor:
                  isDarkMode ? Darktheme.containerColor : Colors.white,
              elevation: 4,
              content: Text(
                'You\'re comment has been submitted',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          );
        }
      },  
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(5),
              horizontal: getProportionateScreenWidth(10)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: InputFieldContainer(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'comment',
                      hintStyle: Theme.of(context).textTheme.headline5,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(12),
                          horizontal: getProportionateScreenWidth(12)),
                    ),
                  ),
                ),
              ),
              horizontalSpacing(10),
              IconButton(
                onPressed: (_controller.text.isNotEmpty)
                    ? () {
                        print("POST COMMENT");
                        BlocProvider.of<PodcastCommentBloc>(context).add(
                          PostPodcastComment(
                            podcastPostModel: PodcastPostModel(
                                content: _controller.text,
                                podcastId: widget.podcastId),
                          ),
                        );
                      }
                    : () {
                        print(_controller.text);
                        print(_controller.text.isNotEmpty);
                      },
                icon: state is PodcastCommentSubmitInProgress
                    ? CircularProgressIndicator(
                        color: Colors.orange,
                      )
                    : Icon(
                        Icons.send_rounded,
                        size: 32,
                        color: Darktheme.primaryColor,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
