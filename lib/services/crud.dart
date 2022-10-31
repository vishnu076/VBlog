//ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
//ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods{
  CollectionReference data=FirebaseFirestore.instance.collection('data');
  Future<void> addData(blogData) async{
    data.add(blogData).catchError((e) {print(e);});
    
  }
}


