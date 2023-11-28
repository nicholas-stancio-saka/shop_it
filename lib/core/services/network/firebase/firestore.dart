import 'package:cloud_firestore/cloud_firestore.dart';

enum AppFirestoreCollectionEnum { users, vouchers, constants }

class AppFirestore {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getDocument(AppFirestoreCollectionEnum collectionEnum, String docId) {
    return db.collection(collectionEnum.name).doc(docId).get();
  }

  Future<void> setDocument(AppFirestoreCollectionEnum collectionEnum, String docId, Map<String, dynamic> data, {bool merge = false}) {
    return db.collection(collectionEnum.name).doc(docId).set(data, SetOptions(merge: merge));
  }

  Future<void> updateDocument(AppFirestoreCollectionEnum collectionEnum, String docId, Map<String, dynamic> data) {
    return db.collection(collectionEnum.name).doc(docId).update(data);
  }

  Future<void> deleteDocument(AppFirestoreCollectionEnum collectionEnum, String docId) {
    return db.collection(collectionEnum.name).doc(docId).delete();
  }

  // New method to get all documents from a specific collection
  Future<QuerySnapshot> getAllDocuments(AppFirestoreCollectionEnum collectionEnum) {
    return db.collection(collectionEnum.name).get();
  }
}
