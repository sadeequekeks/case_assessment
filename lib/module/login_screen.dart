import 'package:case_assessment/widget/button/primary_button.dart';
import 'package:case_assessment/widget/textfield/email_text_field.dart';
import 'package:case_assessment/widget/textfield/pass_text_field.dart';
import 'package:flutter/material.dart';

import '../core/service_injector/service_injector.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image:
                          AssetImage('assets/undraw_Mobile_login_re_9ntv.png'),
                      height: 150.0,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    EmailTextField(
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                      hintText: 'johndoa@example.com',
                      labelText: 'Email',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 15.0),
                    PassTextField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      hintText: 'Enter Password',
                      labelText: 'Password',
                      icon: Icons.password,
                    ),
                    const SizedBox(height: 15.0),
                    PrimaryButton(
                      title: 'Sign In',
                      onTap: (startLoading, stopLoading, btnState) async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          startLoading();
                          await si.authService
                              .loginUser(
                                  email: email.text, password: password.text)
                              .then((user) {
                            if (user.runtimeType == String) {
                              stopLoading();
                              si.dialogService.showToaster(user);
                            } else {
                              startLoading();
                              // si.routerService.popReplaceScreen(
                              //   context,
                              //   BottomNav(
                              //     user: user,
                              //   ),
                              // );
                            }
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 30.0),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Sign up with Google',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
