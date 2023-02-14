import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String details;
  final String postId;
  final Timestamp datePublished;
  final List postUrl;
  final String videoUrl;
  final String profImage;
  final String location;
  final String price;
  final String sharelink;

  const Post(
      {required this.description,
      required this.uid,
      required this.username,
      required this.details,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.videoUrl,
      required this.profImage,
      required this.location,
      required this.price,
      required this.sharelink});

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot["description"],
      uid: snapshot["uid"],
      details: snapshot["details"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      username: snapshot["username"],
      postUrl: snapshot['postUrl'],
      videoUrl: snapshot['videoUrl'],
      profImage: snapshot['profImage'],
      location: snapshot['location'],
      sharelink: snapshot['sharelink'],
      price: snapshot['price'],
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "details": details,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'videoUrl': videoUrl,
        'profImage': profImage,
        'location': location,
        'sharelink': sharelink,
        'price': price
      };
}
