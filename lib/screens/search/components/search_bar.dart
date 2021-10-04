import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
    return Container(
      height: getProportionateScreenHeight(58),
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(30),
          vertical: getProportionateScreenHeight(5)),
      child: Neumorphic(
        style: NeumorphicStyle(
            // depth: -1.5,
            intensity: 1,
            lightSource: LightSource.topLeft,
            shadowDarkColor: Colors.grey.shade200,
            shadowLightColor: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: TextField(
              cursorColor: Colors.grey,
              controller: _controller,
              // textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 20,
              ),
              onChanged: (value) {
                value.length == 0
                    ? _visibilityNotifier.value = false
                    : _visibilityNotifier.value = true;
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8),
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
                            },
                          ),
                        )),
                border: InputBorder.none,
                hintText: "Search",
                filled: true,
                fillColor: Colors.white,
              )),
        ),
      ),
    );
  }
}
