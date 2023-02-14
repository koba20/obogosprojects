// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:matterport/firebase_options.dart';
import 'package:matterport/mainpage.dart';
import 'package:matterport/providers/user_provider.dart';
import 'package:matterport/routes.dart';
import 'package:matterport/screens/splash/splash_screen.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:matterport/theme.dart';
import 'package:provider/provider.dart';
//import 'package:webview_flutter/webview_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
        child: //FlutterWebFrame(
            //builder: (BuildContext context) {
            /*return */ MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(),
          home: MainPage(),
          // home: SplashScreen(),
          // We use routeName so that we dont need to remember the name
          //initialRoute: SplashScreen.routeName,
          //routes: routes,
        ));
  }
  //maximumSize: Size(670.0, 812.0),
  //enabled: kIsWeb,
  //backgroundColor: Colors.grey,
  //  ),
  //);
}
//}
