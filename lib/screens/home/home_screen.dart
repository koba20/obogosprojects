import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matterport/components/coustom_bottom_nav_bar.dart';
import 'package:matterport/enums.dart';
import 'package:matterport/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //addData();
  }

  //addData() async {
  //UserProvider _userProvider =
  //Provider.of<UserProvider>(context, listen: false);
  //await _userProvider.refreshUser();
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          return Body(snapshot);
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
