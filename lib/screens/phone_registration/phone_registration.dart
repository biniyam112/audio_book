import 'package:audio_books/screens/components/custom_appbar.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
// import 'package:get_it/get_it.dart';

import 'components/body.dart';

class PhoneRegistrationScreen extends StatelessWidget {
  const PhoneRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // GetIt getIt = GetIt.instance;
    // getIt.registerSingleton<User>(User());

    return Scaffold(
      appBar: customAppBar(context: context, title: 'Register Phone'),
      body: SingleChildScrollView(child: Body()),
    );
  }
}

// class Body extends StatelessWidget {
//   const Body({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: getProportionateScreenWidth(30),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: SizeConfig.screenHeight! * .2),
//           Text(
//             'Enter \nPhone number',
//             style:
//                 Theme.of(context).textTheme.headline3!.copyWith(fontSize: 30),
//           ),
//           verticalSpacing(20),
//           Text(
//             'we will send you verification code',
//             style: Theme.of(context).textTheme.headline6!.copyWith(
//                   color: isDarkMode ? Colors.white38 : Colors.black38,
//                 ),
//           ),
//           PhoneForm(),
//           ElevatedButton(
//             onPressed: () {},
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Next',
//                     style: Theme.of(context).textTheme.headline5!.copyWith(
//                           color: Colors.white,
//                         ),
//                   ),
//                   horizontalSpacing(5),
//                   Icon(
//                     CupertinoIcons.arrow_right,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PhoneForm extends StatefulWidget {
//   const PhoneForm({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _PhoneFormState createState() => _PhoneFormState();
// }

// class _PhoneFormState extends State<PhoneForm> {
//   Country? _selectedCountry;
//   late String phoneNumber;

//   void _showCountryPicker() async {
//     final country = await showCountryPickerSheet(
//       context,
//     );
//     if (country != null) {
//       setState(() {
//         _selectedCountry = country;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final country = _selectedCountry;
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
//       child: TextFormField(
//           onChanged: (value) {
//             phoneNumber = value;
//           },
//           decoration: InputDecoration(
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: Colors.black, width: 1.3)),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: Colors.black, width: 1.3)),
//               isDense: true,
//               prefixStyle: TextStyle(color: Colors.transparent),
//               contentPadding: EdgeInsets.symmetric(
//                   vertical: getProportionateScreenHeight(10)),
//               prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
//               prefixIcon: InkWell(
//                 onTap: () {
//                   _showCountryPicker();
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: getProportionateScreenWidth(5)),
//                   child: RichText(
//                       text: TextSpan(
//                     children: [
//                       country == null
//                           ? WidgetSpan(
//                               child: Icon(
//                                 CupertinoIcons.chevron_up,
//                                 color: Colors.black,
//                                 size: getProportionateScreenHeight(20),
//                               ),
//                             )
//                           : WidgetSpan(
//                               child: Container(
//                                 height: getProportionateScreenWidth(30),
//                                 width: getProportionateScreenWidth(30),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(
//                                     getProportionateScreenWidth(10),
//                                   ),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(
//                                     getProportionateScreenWidth(10),
//                                   ),
//                                   child: Image.asset(
//                                     country.flag,
//                                     package: countryCodePackageName,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                       country == null
//                           ? TextSpan(
//                               text: 'select ',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: getProportionateScreenHeight(20)),
//                             )
//                           : WidgetSpan(
//                               child: Padding(
//                               child: Text(country.countryCode,
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize:
//                                           getProportionateScreenHeight(20))),
//                               padding: EdgeInsets.symmetric(horizontal: 10),
//                             ))
//                     ],
//                   )),
//                 ),
//               ))),
//     );
//   }
// }
