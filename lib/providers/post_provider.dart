import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class PostProvider with ChangeNotifier {
  PostProvider() {}

  Future<DocumentSnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection("post")
        .doc("postId")
        .get();
  }
}
