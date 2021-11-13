import 'package:audio_books/theme/theme.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import '../../sizeConfig.dart';

class BuildPhoneField extends StatefulWidget {
  BuildPhoneField({
    Key? key,
    required this.errors,
    required this.country,
    required this.controller,
  }) : super(key: key);
  final List<String> errors;
  final Country country;
  final TextEditingController controller;

  @override
  _BuildPhoneFieldState createState() => _BuildPhoneFieldState();
}

class _BuildPhoneFieldState extends State<BuildPhoneField> {
  late Country _selectedCountry = widget.country;
  String modifyText() {
    String text = widget.controller.text.replaceAll(' ', '');
    List textList = text.split("");
    for (var i = 0; i < textList.length; i++) {
      if (i % 4 == 0) textList.insert(i, ' ');
    }
    return textList.join();
  }

  void _showCountryPicker() async {
    final country = await showCountryPickerSheet(
      context,
      title: Text(
        'Select Country',
        style: Theme.of(context).textTheme.headline4,
      ),
      heightFactor: .8,
      cancelWidget: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Darktheme.primaryColor,
                ),
          ),
        ),
      ),
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
        if (widget.errors.contains(kCountryCodeNullError)) {
          widget.errors.remove(kCountryCodeNullError);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: Theme.of(context).textTheme.headline5!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
      autofocus: true,
      enabled: true,
      validator: (value) {
        if (value!.isEmpty && !widget.errors.contains(kPhoneNullError)) {
          setState(() {
            widget.errors.add(kPhoneNullError);
          });
          return '';
        }
        if (value.isEmpty && widget.errors.contains(kPhoneNullError)) {
          return '';
        }
      },
      onChanged: (value) {
        widget.controller.text = modifyText();
        widget.controller.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.controller.text.length));
        if (value.isNotEmpty && widget.errors.contains(kPhoneNullError)) {
          setState(() {
            widget.errors.remove(kPhoneNullError);
          });
        }
      },
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(10),
        ),
        hintText: 'phone',
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            getProportionateScreenWidth(10),
            getProportionateScreenWidth(20),
            getProportionateScreenWidth(10),
          ),
          child: SvgPicture.asset('assets/icons/Phone.svg'),
        ),
        hintStyle: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black45),
        prefix: GestureDetector(
          onTap: () {
            _showCountryPicker();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: getProportionateScreenWidth(30),
                width: getProportionateScreenWidth(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(10),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(10),
                  ),
                  child: Image.asset(
                    _selectedCountry.flag,
                    package: countryCodePackageName,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6, right: 18),
                child: Text(
                  _selectedCountry.callingCode,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
