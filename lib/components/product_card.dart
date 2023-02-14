import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matterport/models/Product.dart';
import 'package:matterport/models/post.dart';
import 'package:matterport/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    //required this.product,
    required this.snap,
  }) : super(key: key);

  final double width, aspectRetio;
  //final Product product;
  final Map<String, dynamic> snap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            print(snap);
            return DetailsScreen(snap: snap);
          }));
        },

        /* Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: ProductDetailsArguments(product: snap),
        ),*/
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
              height: 170.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          child: Text(
                            snap['details'],
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          '\N${snap['price']}',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    /* Text(
                                  //activity.type,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),*/
                    //_buildRatingStars(activity.rating),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20.0,
              top: 15.0,
              bottom: 15.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  width: 110.0,
                  image: NetworkImage(
                    snap['postUrl'][0],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
   
    
    
    
    /*Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            //arguments: ProductDetailsArguments(product: product),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),*/
              //child: Hero(
              //tag: snap.toString(),
              Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/real-estate-app-564a4.appspot.com/o/posts%2FdY4EA9AjLtb5dOBYuzH3NmAAtXD2%2F0e5755a0-f02a-11ec-9f30-13514161625d?alt=media&token=f40d94c1-569c-410d-ab17-13e11a0f86ba"),

              // ),
              // ),
              //),
              const SizedBox(height: 10),
              Text(
                snap['details'],
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\N${snap['price']}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  /*InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.15),
                        //: kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/Heart Icon_2.svg",
                          color: Color(0xFFFF4848)
                          //: Color(0xFFDBDEE4),
                          ),
                    ),
                  ),*/
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}*/
