import 'package:audio_books/models/user.dart';
import 'package:hive/hive.dart';

class HiveBoxes {
  static String userKey = 'USER';
  static Box<User> getUserBox() => Hive.box<User>('user');

  static bool hasUserSigned() {
    final userBox = HiveBoxes.getUserBox();

    // final userData = userBox.get(HiveBoxes.userKey);
    // print("PRINT USER DATA *********${userData!.firstName}");
    return userBox.containsKey(HiveBoxes.userKey);
  }
}
