// padding and animation
const defaultPadding = 20.0;
const slowDuration = Duration(milliseconds: 800);
const fastDuration = Duration(milliseconds: 400);
const superFastDuration = Duration(microseconds: 300);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kFirstNameNullError = "Please enter your first name";
const String kLastNameNullError = "Please enter your last name";
const String kPhoneNullError = "Please Enter phone number";
const String kOtpError="OTP error";
const String kCountryCodeNullError = "Please select country code";
const String kInvalidPhoneNumberError = "Please enter valid phone number";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kFristNameNullError = "Please Enter your firstname";
const String klastNameNullError = "Please Enter your lastname";
const String kAddressNullError = "Please Enter your address";
