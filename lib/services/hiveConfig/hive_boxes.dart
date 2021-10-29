import 'package:audio_books/models/user.dart';
import 'package:hive/hive.dart';

class HiveBoxes {
  static String userKey = 'USER';
  static Box<User> getUserBox() => Hive.box<User>('user');

  static bool hasUserSigned() {
    final userBox = HiveBoxes.getUserBox();
    return userBox.containsKey(HiveBoxes.userKey);
  }
}
