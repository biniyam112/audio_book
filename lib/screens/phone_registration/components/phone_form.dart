import 'package:audio_books/constants.dart';
import 'package:audio_books/feature/otp/otp.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/screens/otp/otp.dart';
import 'package:audio_books/screens/screens.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneForm extends StatefulWidget {
  const PhoneForm({
    Key? key,
  }) : super(key: key);

  @override
  _PhoneFormState createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  @override
  void initState() {
    super.initState();
    _selectedCountry = Country.fromJson(
      {
        "country_code": "ET",
        "name": "Ethiopia",
        "calling_code": "+251",
        "flag": "flags/eth.png"
      },
    );
  }

  TextEditingController _controller = TextEditingController();
  Country? _selectedCountry;
  late String phoneNumber;
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];

  String modifyText() {
    String text = _controller.text.replaceAll(' ', '');
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
        if (errors.contains(kCountryCodeNullError)) {
          errors.remove(kCountryCodeNullError);
        }
        GetIt.instance;
        var user = getIt.get<User>();
        user.setCountryCode = country.callingCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpInProgress) {
          errors.remove(kOtpError);
        } else if (state is OtpSent) {
          errors.remove(kOtpError);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (cotext) {
                return OTPScreen();
              },
            ),
          );
        } else if (state is OtpFailure) {
          errors.add(kOtpError);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              InputFieldContainer(
                title: 'Phone',
                child: TextFormField(
                  controller: _controller,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                  validator: (value) {
                    if (value!.isEmpty && !errors.contains(kPhoneNullError)) {
                      setState(() {
                        errors.add(kPhoneNullError);
                      });
                      return '';
                    }
                    if (value.isEmpty && errors.contains(kPhoneNullError)) {
                      return '';
                    }
                  },
                  onChanged: (value) {
                    _controller.text = modifyText();
                    _controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: _controller.text.length));
                    if (value.isNotEmpty && errors.contains(kPhoneNullError)) {
                      setState(() {
                        errors.remove(kPhoneNullError);
                      });
                    }
                    phoneNumber = value.replaceAll(' ', '');
                    var user = getIt.get<User>();
                    user.setPhoneNumber = value;
                  },
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10),
                      vertical: getProportionateScreenHeight(10),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        getProportionateScreenWidth(10),
                        getProportionateScreenWidth(20),
                        getProportionateScreenWidth(10),
                      ),
                      child: SvgPicture.asset('assets/icons/Phone.svg'),
                    ),
                    hintText: 'phone',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.black45),
                    prefixIcon: GestureDetector(
                      onTap: () {
                        _showCountryPicker();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _selectedCountry == null
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    right: getProportionateScreenWidth(10),
                                    left: 2,
                                  ),
                                  child: Icon(CupertinoIcons.chevron_up),
                                )
                              : Container(
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
                                      _selectedCountry!.flag,
                                      package: countryCodePackageName,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          if (_selectedCountry != null)
                            Padding(
                              padding: EdgeInsets.only(left: 6, right: 18),
                              child: Text(
                                _selectedCountry!.callingCode,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpacing(20),
              FormError(errors: errors),
              verticalSpacing(24),
              Center(
                child: Container(
                  height: getProportionateScreenHeight(42),
                  width: double.infinity,
                  child: state is OtpInProgress
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            _formKey.currentState!.validate();
                            var user = getIt.get<User>();
                            if (_selectedCountry == null &&
                                !errors.contains(kCountryCodeNullError)) {
                              setState(() {
                                errors.add(kCountryCodeNullError);
                              });
                            } else if (_selectedCountry != null &&
                                !errors.contains(kCountryCodeNullError)) {
                              setState(() {
                                errors.remove(kCountryCodeNullError);
                              });
                            }
                            if (user.countryCode!.isNotEmpty &&
                                user.phoneNumber!.isNotEmpty) {
                              final phoneNumber =
                                  '${user.countryCode}${user.phoneNumber}';
                              print("OTP BLOC STATE $state");
                              print(
                                  "USER PHONE*********************$phoneNumber");
                              BlocProvider.of<OtpBloc>(context)
                                  .add(SendOtp(phoneNumber: phoneNumber));
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenWidth(6)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Next',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                horizontalSpacing(4),
                                Icon(
                                  CupertinoIcons.chevron_right,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
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
