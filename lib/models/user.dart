import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? token;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? firstName;

  @HiveField(4)
  String? lastName;

  @HiveField(5)
  String? phoneNumber;

  @HiveField(6)
  String? countryCode;
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.countryCode,
    this.token,
    this.email,
  });

  factory User.copywith(User user) => User(
        id: user.id,
        countryCode: user.countryCode,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        phoneNumber: user.phoneNumber,
        token: user.token,
      );

  Map<String, dynamic> tomap() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'countryCode': countryCode,
        'token': token,
      };
  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        countryCode: json['countryCode'],
        token: json['token'],
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

  set setToken(String token) {
    this.token = token;
  }
}
