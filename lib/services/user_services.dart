part of 'services.dart';

class UserServices {
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  static DocumentReference userDoc;

  static Reference ref;
  static UploadTask uploadTask;

  static String imgUrl;

  static Future<void> updateUser(Users users) async {
    userCollection.doc(users.uid).set({
      'uid': users.uid,
      'email': users.email,
      'name': users.name,
      'profilePicture': users.profilePicture ?? ""
    });
  }

  static Future<bool> updateProfile(String id, PickedFile imgFile) async {
    if (imgFile != null) {
      ref = FirebaseStorage.instance
          .ref()
          .child("images/users")
          .child(id + ".png");
      uploadTask = ref.putFile(File(imgFile.path));

      await uploadTask.whenComplete(() => ref.getDownloadURL().then(
            (value) => imgUrl = value,
          ));

      userCollection.doc(id).update({'profilePicture': imgUrl});

      return true;
    } else {
      return false;
    }
  }
}
