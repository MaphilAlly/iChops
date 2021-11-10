import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SearchController extends GetxController {
  String collectionName;
  SearchController({
  this.collectionName,
  });

  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  Future queryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}
