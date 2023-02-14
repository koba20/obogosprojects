import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  final String userEmail;
  final String userPassword;
  final String role;
  CompleteProfileScreen(this.userEmail, this.userPassword, this.role);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(userEmail, userPassword, role),
    );
  }
}
