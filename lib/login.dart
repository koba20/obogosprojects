import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:matterport/homescreen.dart';
import 'package:matterport/registration.dart';
import 'package:matterport/resources/auth_methods.dart';
//import 'package:real_estate/pages/reg_screen.dart';
//import 'package:real_estate/pages/root.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  //final _formKey = GlobalKey<FormState>();

  //editing controller
  final /*TextEditingController*/ _emailEditingController =
      TextEditingController();
  final /*TextEditingController*/ _passwordController = TextEditingController();
  bool isloading = true;
  //firebase
  //final _auth = FirebaseAuth.instance;

  Future signIn() async {
    /*await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailEditingController.text.trim(),
      password: _passwordController.text.trim(),
    );*/
    String res = await AuthMethods().loginUser(
        email: _emailEditingController.text,
        password: _passwordController.text);

    if (res == 'success') {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextField(
      autofocus: false,
      controller: _emailEditingController,
      keyboardType: TextInputType.emailAddress,
      /*validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        //reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a Valid Email");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },*/
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //password field
    final passwordField = TextField(
      autofocus: false,
      controller: _passwordController,
      obscureText: true,
      /*validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is Required for Login");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter Valid Password (Minimum 6 Characters");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },*/
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.password),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const /*RootApp()*/ HomeScreen()));
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 250,
              padding: const EdgeInsets.only(top: 50),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blueGrey,
                        Colors.blueGrey,
                      ]),
                  //color: Colors.blueGrey,
                  /* image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/cu-logo.png",
                    ),
                  ),*/
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              //child: Align(
              //alignment: Alignment.topCenter,
              child: Image.asset("assets/images/cu-logo.png"),
              //),
              width: double.infinity,
              //color: Colors.blueGrey,
              //decoration: BoxDecoration(border: ),
              /*child: Image.asset(
                "assets/images/cu-logo.png",
                height: 200,
                fit: BoxFit.contain,
              ),*/
            ),
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 45),
                    emailField,
                    const SizedBox(height: 25),
                    passwordField,
                    const SizedBox(height: 35),
                    loginButton,
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const RegistrationScreen())));
                          },
                          child: const Text(
                            "SignUp",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  //login function
  /*void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (uid) => {
              Fluttertoast.showToast(msg: "Login Successful"),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen())),
            },
          )
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}*/
