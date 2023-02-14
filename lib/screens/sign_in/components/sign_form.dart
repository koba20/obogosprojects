import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:matterport/components/custom_surfix_icon.dart';
import 'package:matterport/components/form_error.dart';
import 'package:matterport/helper/keyboard.dart';
import 'package:matterport/resources/auth_methods.dart';
import 'package:matterport/screens/forgot_password/forgot_password_screen.dart';
import 'package:matterport/screens/login_success/login_success_screen.dart';
import 'package:matterport/utils/utils.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool? remember = false;
  final List<String?> errors = [];
  bool _isLoading = false;
  String msg = "Username or Password invalid";

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      KeyboardUtil.hideKeyboard(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginSuccessScreen()),
      );
      //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        addError(error: msg);
        _isLoading = false;
      });
      print(res);
      //showSnackBar(context, res);
    }
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_emailController.text.isNotEmpty) {
                removeError(error: kEmailNullError);
              }
              if (emailValidatorRegExp.hasMatch(_emailController.text)) {
                removeError(error: kInvalidEmailError);
              }
              if (_emailController.text.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              }
              if (!emailValidatorRegExp.hasMatch(_emailController.text)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              if (_passwordController.text.isNotEmpty) {
                removeError(error: kPassNullError);
              }
              if (_passwordController.text.length >= 8) {
                removeError(error: kShortPassError);
              }
              if (_passwordController.text.isEmpty) {
                addError(error: kPassNullError);
              }
              if (_passwordController.text.length < 8) {
                addError(error: kShortPassError);
              } else {
                loginUser();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      //onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      //onSaved: (newValue) => email = newValue,
      controller: _emailController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
