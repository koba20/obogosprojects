import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matterport/components/custom_surfix_icon.dart';
import 'package:matterport/components/default_button.dart';
import 'package:matterport/components/form_error.dart';
import 'package:matterport/resources/auth_methods.dart';
import 'package:matterport/screens/otp/otp_screen.dart';
import 'package:matterport/screens/sign_in/sign_in_screen.dart';
import 'package:matterport/screens/sign_up/components/sign_up_form.dart'
    as obogo;
import 'package:matterport/utils/utils.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  final String userEmail;
  final String userPassword;
  final String role;
  CompleteProfileForm(this.userEmail, this.userPassword, this.role);
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;

  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final middleNameEditingController = TextEditingController();
  final numberEditingController = TextEditingController();
  //final confirmPinEditingController = TextEditingController();
  var _currentRole;
  Uint8List? _image;

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void signUpUser() async {
    String res = await AuthMethods().signUpUser(
        email: widget.userEmail,
        password: widget.userPassword,
        username: firstNameEditingController.text,
        //bio: bio,
        //file: _image!,
        number: numberEditingController.text,
        role: widget.role);
    if (res != 'success') {
      addError(error: res);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final arg = ModalRoute.of(context)!.settings.arguments;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildMiddleNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                signUpUser();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildMiddleNameFormField() {
    return TextFormField(
      controller: middleNameEditingController,
      onSaved: (newValue) => address = newValue,
      /*onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },*/
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your middle name(if any)",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: numberEditingController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (numberEditingController.text.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (numberEditingController.text.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: secondNameEditingController,
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: firstNameEditingController,
      //onSaved: (newValue) => firstNameEditingController.text = newValue!,
      onChanged: (value) {
        if (firstNameEditingController.text.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (firstNameEditingController.text.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
