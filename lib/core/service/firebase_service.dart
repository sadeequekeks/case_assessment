import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //add
  Future<bool?> addDoc(
      {required String collection,
      required Map<String, dynamic> data,
      String? id}) async {
    bool? isDocAdded;
    try {
      await _fireStore.collection(collection).doc(id).set(data).then((value) {
        isDocAdded = true;
      });
    } catch (e) {
      isDocAdded = false;
    }
    return isDocAdded;
  }

  //get one
  Future<DocumentSnapshot<Map<String, dynamic>>?> getOneDoc(
      {required String collection, required String id}) async {
    DocumentSnapshot<Map<String, dynamic>>? doc;
    await _fireStore.collection(collection).doc(id).get().then((value) {
      doc = value;
    });
    return doc;
  }
}
