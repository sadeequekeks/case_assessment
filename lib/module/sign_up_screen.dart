import 'package:case_assessment/widget/button/primary_button.dart';
import 'package:case_assessment/widget/textfield/email_text_field.dart';
import 'package:case_assessment/widget/textfield/pass_text_field.dart';
import 'package:case_assessment/widget/textfield/text_field.dart';

import 'package:flutter/material.dart';

import '../core/service_injector/service_injector.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  List<TextEditingController> controllers = [];

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 30.0),
                InputTextField(
                  controller: name,
                  hintText: 'John Doe',
                  labelText: 'Enter your name',
                  icon: Icons.person,
                ),
                const SizedBox(height: 15.0),
                EmailTextField(
                  controller: email,
                  hintText: 'johndoe@example.com',
                  labelText: 'email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 15.0),
                PassTextField(
                  controller: password,
                  hintText: '*******',
                  labelText: 'Password',
                  icon: Icons.password,
                ),
                const SizedBox(height: 15.0),
                const SizedBox(height: 15.0),
                const SizedBox(height: 20.0),
                isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      )
                    : PrimaryButton(
                        title: 'Sign up',
                        onTap: (startLoading, stopLoading, btnState) async {
                          startLoading();
                          await si.authService
                              .register(
                            email: email.text,
                            password: password.text,
                            name: name.text,
                          )
                              .then((id) {
                            if (id!.isNotEmpty) {
                              stopLoading();
                              si.dialogService.showToaster(
                                  '${name.text} has been created successfully');
                              si.utilityService.clearFields(controllers);
                            } else {
                              stopLoading();
                              si.dialogService.showToaster(
                                  'An error occured while registering a user');
                            }
                          });
                        },
                      ),
                const SizedBox(height: 17.0),
                const Text(
                  'By continuing you agree to our',
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Terms & Conditions',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
