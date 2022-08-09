import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  late String uid;
  late int impressions;

  UserData({required this.uid, required this.impressions});
}
