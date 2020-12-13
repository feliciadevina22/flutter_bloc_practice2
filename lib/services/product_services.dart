part of 'services.dart';

class ProductServices {
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection("products");
  static DocumentReference productDoc;

  // Setup Firestore Storage
  static Reference ref;
  static UploadTask uploadTask;

  static String imgUrl;

  static Future<bool> addProduct(Products product, PickedFile imgFile) async {
    await Firebase.initializeApp();

    productDoc = await productCollection.add({
      'id': "",
      'name': product.name,
      'price': product.price,
      'image': "",
    });

    if (productDoc.id != null) {
      ref = FirebaseStorage.instance
          .ref()
          .child("images/products")
          .child(productDoc.id + ".png");
      uploadTask = ref.putFile(File(imgFile.path));

      await uploadTask.whenComplete(() => ref.getDownloadURL().then(
            (value) => imgUrl = value,
          ));

      productCollection
          .doc(productDoc.id)
          .update({'id': productDoc.id, 'image': imgUrl});

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateProduct(Products product,
      [PickedFile imgFile]) async {
    await Firebase.initializeApp();

    if (product.id != null) {
      if (imgFile != null) {
        ref = FirebaseStorage.instance
            .ref()
            .child("images/products")
            .child(product.id + ".png");
        uploadTask = ref.putFile(File(imgFile.path));

        await uploadTask.whenComplete(() => ref.getDownloadURL().then(
              (value) => imgUrl = value,
            ));

        productCollection.doc(product.id).update({
          'name': product.name,
          'price': product.price,
          'image': imgUrl,
        });
      } else {
        productCollection.doc(product.id).update({
          'name': product.name,
          'price': product.price,
          'image': product.image,
        });
      }

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteProduct(Products product) async {
    await Firebase.initializeApp();

    if (product.id != null) {
      ref = FirebaseStorage.instance.ref().child("images/products");

      ref.child(product.id + ".png").delete();
      productCollection.doc(product.id).delete();

      return true;
    } else {
      return false;
    }
  }
}
