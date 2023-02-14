import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matterport/components/default_button.dart';
import 'package:matterport/models/post.dart';
import 'package:matterport/screens/details/components/product_description.dart';
import 'package:matterport/screens/details/components/product_images.dart';
import 'package:matterport/screens/details/components/top_rounded_container.dart';
import 'package:matterport/screens/details/components/videoplayer.dart';
import 'package:matterport/screens/details/components/webview.dart';
import 'package:matterport/size_config.dart';

import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  final Map<String, dynamic> snap;

  DetailsScreen({required this.snap, Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    //final ProductDetailsArguments agrs =
    // ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    Post post = Post(
        description: widget.snap['description'],
        uid: widget.snap['uid'],
        username: widget.snap['username'],
        details: widget.snap['details'],
        postId: widget.snap['postId'],
        datePublished: widget.snap['datePublished'],
        postUrl: widget.snap['postUrl'],
        videoUrl: widget.snap['videoUrl'],
        location: widget.snap['location'],
        price: widget.snap['price'],
        sharelink: widget.snap['sharelink'],
        profImage: widget.snap['profImage']);

    return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        //appBar: PreferredSize(
        //preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        //child: CustomAppBar(rating: agrs.product.rating),
        //),
        body: ListView(
          children: [
            ProductImages(snap: post),
            TopRoundedContainer(
              color: Colors.white,
              child: Column(
                children: [
                  ProductDescription(
                    snap: post,
                    pressOnSeeMore: () {},
                  ),
                  TopRoundedContainer(
                    color: Color(0xFFF6F7F9),
                    child: Column(
                      children: [
                        //ColorDots(product: product),
                        TopRoundedContainer(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.15,
                              right: SizeConfig.screenWidth * 0.15,
                              bottom: getProportionateScreenWidth(40),
                              top: getProportionateScreenWidth(15),
                            ),
                            child: DefaultButton(
                              text: "View 360 Video",
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          WebViewApp(snap: post),
                                    ));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class ProductDetailsArguments {
  final product;

  ProductDetailsArguments({required this.product});
}
