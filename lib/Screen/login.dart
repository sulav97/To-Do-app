import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do_app/Screen/register.dart';
import 'package:to_do_app/Widget/bottombar.dart';
import '../Widget/Texffieldform.dart';
import '../Widget/button.dart';
import '../utils/app_style.dart';
import 'homepage.dart';
import '../firebase.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'asset/images/login.jpg',
                height: 300,
                fit: BoxFit.cover,
              ),
              Text(
                'Login',
                style: style.textStyle,
              ),
              Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'E-mail / username is required';
                    }
                    return null;
                  },
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.person_outline),
                    hintText: 'Enter your E-mail',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password is required';
                    } else if (value.length < 8) {
                      return 'password must be at least 8 chr ';
                    }
                    return null;
                  },
                  controller: _password,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.lock),
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      const Size.fromWidth(double.infinity),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(10),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _email.text, password: _password.text)
                            .then((value) async {
                          await dataFirebase.getuser();
                          Get.off(() => const BottomBar());
                        }).onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.white,
                              behavior: SnackBarBehavior.floating,
                              elevation: 0,
                              content: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                height: 80,
                                child: Text(
                                    'The Email or password is/are wrong, please try again'),
                              ),
                            ),
                          );
                          ;
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: const Text(
                    'login',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Do not have an account,'),
                  TextButton(
                    onPressed: () {
                      Get.off(() => const Register());
                    },
                    child: Text(
                      'Register from here',
                      style: TextStyle(
                        color: style.lightgreen,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
