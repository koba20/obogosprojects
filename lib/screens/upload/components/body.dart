import 'package:flutter/material.dart';
import 'package:matterport/constants.dart';
import 'package:matterport/screens/upload/components/upload_form.dart';
import 'package:matterport/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Upload Property", style: headingStyle),
                Text(
                  "Complete all the details regarding \nthe property",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                Upload_Form(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
