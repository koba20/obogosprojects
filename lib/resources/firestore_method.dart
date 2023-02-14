import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:matterport/models/post.dart';
import 'package:matterport/models/user.dart';
import 'package:matterport/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Post> getPostDetails() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('post').doc().get();

    return Post.fromSnap(documentSnapshot);
  }

  Future<String> uploadPost(
      String description,
      String details,
      List<Uint8List> file,
      Uint8List? video,
      String location,
      String uid,
      String username,
      String profImage,
      String sharelink,
      String price) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      List photoUrl = [];
      //await StorageMethods().uploadImageToStorage('posts', file, true);
      for (Uint8List img in file) {
        String ref =
            await StorageMethods().uploadImageToStorage('posts', img, true);
        photoUrl.add(ref);
      }
      String vidUrl =
          await StorageMethods().uploadImageToStorage('posts', video!, true);

      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        location: location,
        postId: postId,
        datePublished: Timestamp.fromDate(DateTime.now()),
        postUrl: photoUrl,
        profImage: profImage,
        details: details,
        videoUrl: vidUrl,
        sharelink: sharelink,
        price: price,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
