class User {
  int? id;
  String? token, email, password;
  String? firstName, lastName, phoneNumber, countryCode;
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.countryCode,
    this.token,
    this.email,
    this.password,
  });

  Map<String, dynamic> tomap() => {
        'id': 0,
        'firstName': firstName,
        'lastName': lastName,
        'email': email ?? '',
        'phoneNumber': phoneNumber,
        'countryCode': countryCode,
      };
  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        countryCode: json['countryCode'],
      );

  set setFirstName(String firstName) {
    this.firstName = firstName;
  }

  set setLastName(String lastName) {
    this.lastName = lastName;
  }

  set setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  set setCountryCode(String countryCode) {
    this.countryCode = countryCode;
  }
}
