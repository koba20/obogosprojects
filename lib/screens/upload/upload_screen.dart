import 'package:flutter/material.dart';
import 'package:matterport/screens/upload/components/body.dart';

class UploadScreen extends StatelessWidget {
  static String routeName = "/upload_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Body(),
    );
  }
}
