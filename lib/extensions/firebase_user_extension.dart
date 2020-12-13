part of 'extensions.dart';

//FirebaseUser --> User
extension FirebaseUserExtension on User {
  Users convertToUser({String name = "No Name"}) =>
      Users(this.uid, this.email, name: name);
}
