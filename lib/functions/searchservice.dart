import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('offers')
        .where('searchKey', isEqualTo: searchField.substring(0).toUpperCase())
        .getDocuments();
  }
}
