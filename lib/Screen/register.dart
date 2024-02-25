import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/Screen/homepage.dart';
import 'package:to_do_app/Screen/login.dart';
import 'package:to_do_app/Widget/bottombar.dart';
import '../Model/user.dart';
import '../Widget/Texffieldform.dart';
import '../Widget/button.dart';
import '../utils/app_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool loading = false;
  String? error;
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
                'asset/images/register.jpg',
                height: 300,
                fit: BoxFit.cover,
              ),
              Text(
                'Register',
                style: style.textStyle,
              ),
              Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'E-mail is required';
                    } else if (value.isEmail == false) {
                      return 'Please Enter an E-mail';
                    }
                    return null;
                  },
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.email_outlined),
                    hintText: 'Enter your Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'UserName is required';
                    }
                    return null;
                  },
                  controller: _username,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.person_outlined),
                    hintText: 'Enter your UserName',
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
                      return 'Password is required';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 chr ';
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
                    // if (_formKey.currentState!.validate()) {
                    //   FirebaseAuth.instance
                    //       .createUserWithEmailAndPassword(
                    //           email: _email.text, password: _password.text)
                    //       .then((value) {
                    //     //loading spinier
                    //     Get.off(() => const BottomBar());
                    //   }).onError((error, stackTrace) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         backgroundColor: Colors.white,
                    //         behavior: SnackBarBehavior.floating,
                    //         elevation: 0,
                    //         content: Container(
                    //           margin: const EdgeInsets.all(10),
                    //           padding: const EdgeInsets.all(10),
                    //           decoration: const BoxDecoration(
                    //             color: Colors.redAccent,
                    //             borderRadius:
                    //                 BorderRadius.all(Radius.circular(10)),
                    //           ),
                    //           height: 80,
                    //           child: Text(error.toString() ==
                    //                   '[firebase_auth/email-already-in-use] The email address is already in use by another account.'
                    //               ? ' The email address is already used, please enter other E-mail.'
                    //               : 'Something went wrong, please try agin.'),
                    //         ),
                    //       ),
                    //     );
                    //     ;
                    //   });
                    // }
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _email.text, password: _password.text);
                        await dataFirebase.RegisterUser(
                            _email.text, _username.text);
                        dataFirebase.getuser();
                        Get.off(() => const BottomBar());
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          error = 'The password is weak';
                        } else if (e.code == 'email-already-in-use') {
                          error =
                              'The email address is already used, please enter other E-mail';
                        }
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
                              child: Text(error!),
                            ),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account,'),
                  TextButton(
                    onPressed: () {
                      Get.off(() => const Login());
                    },
                    child: Text(
                      'Login from here',
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
