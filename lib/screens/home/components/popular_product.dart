import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matterport/components/product_card.dart';
import 'package:matterport/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  PopularProducts(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Recent Properties", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              /*...List.generate(
                snapshot.data!.docs.length,
                (index) {
                  return ProductCard(snap: snapshot.data!.docs[index].data());

                  //return SizedBox
                     // .shrink(); // here by default width and height is 0
                },
              ),*/
              Container(
                height: 1000,
                child: ListView.builder(

                    //padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                          snap: snapshot.data!.docs[index].data());
                    }),
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
