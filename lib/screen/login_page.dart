import 'dart:convert';
import 'package:admin_app/api_service/custom_api.dart';
import 'package:admin_app/screen/bottom_nav/bottom_nav.dart';
import 'package:admin_app/widget/const.dart';
import 'package:admin_app/widget/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    isLogin();
    super.initState();
  }

  isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavPage()));
    }
  }

  getLogin() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      setState(() {
        isLoading = true;
      });
      final result = await CustomHttp.login(
          emailController.text, passwordController.text);
      setState(() {
        isLoading = false;
      });
      final data = jsonDecode(result);
      if (data["access_token"] != null) {
        setState(() {
          sharedPreferences.setString("token", data["access_token"]);
          sharedPreferences.setString("email", emailController.text);
          print("my token save${sharedPreferences.getString("token")}");
        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomNavPage()));
      }

      print("TTTTTTTTTTTTTTTT$data");
    } catch (e) {
      print("$e");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        //dismissible: false,
        blur: 1,
        opacity: 0.5,

        progressIndicator: CircularProgressIndicator(),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login  Koro",
                style: myStyle(
                  25,
                  Colors.pink,
                ),
              ),
              CustomTextField(
                controller: emailController,
                hintText: "Enter your email",
                lebelText: "Enter your email",
              ),
              CustomTextField(
                controller: passwordController,
                hintText: "Enter your password",
                lebelText: "Enter your password",
              ),
              ElevatedButton(
                  onPressed: () {
                    getLogin();
                  },
                  child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
