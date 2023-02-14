import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String role;
  final String number;
  final List followers;
  final List following;

  const User({
    required this.role,
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.number,
    required this.followers,
    required this.following,
  });

  static User fromSnap(DocumentSnapshot snap) {
    Map snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      number: snapshot["number"],
      followers: snapshot["followers"],
      following: snapshot["following"],
      role: snapshot["role"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "number": number,
        "followers": followers,
        "following": following,
        "role": role,
      };
}
