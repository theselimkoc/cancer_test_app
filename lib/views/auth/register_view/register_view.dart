// ignore_for_file: unused_local_variable, unused_element, avoid_print, use_build_context_synchronously

import 'package:cancer_test_app/models/user/create_user_model.dart';
import 'package:cancer_test_app/models/user/user_model.dart';
import 'package:cancer_test_app/services/firebase_database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cancer_test_app/components/colon_title.dart';
import 'package:cancer_test_app/components/custom_text_field.dart';
import 'package:cancer_test_app/components/general_container.dart';
import 'package:cancer_test_app/constants/paddings.dart';
import 'package:cancer_test_app/services/firebase_auth_services.dart';
import 'package:cancer_test_app/views/auth/login_view/login_view.dart';

part 'register_mixin.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with RegisterMixin {
  final FirebaseAuthService _auth = FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: handleBack,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Kayıt ol",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: CPaddings.contentPadding,
        child: Center(
          child: GeneralContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                const ColonTitle(data: "İsim"),
                CustomTextField(
                  controller: _userNameController,
                  hintText: "İsminizi giriniz",
                ),
                const SizedBox(height: 10),
                const ColonTitle(data: "Yaş:"),
                CustomTextField(
                  controller: _ageController,
                  hintText: "Yaşınızı giriniz",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30),
                const ColonTitle(data: "E-mail:"),
                CustomTextField(
                  controller: _emailController,
                  hintText: "E-mail adresinizi giriniz",
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                const ColonTitle(data: "Parola:"),
                CustomTextField(
                  controller: _passwordController,
                  hintText: "Parolanızı oluşturunuz",
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _signUp(
                    CreateUserModel(
                      email: _emailController.text,
                      password: _passwordController.text,
                      name: _userNameController.text,
                      age: _ageController.text,
                    ),
                  ),
                  child: const Text("Kayıt ol"),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp(CreateUserModel model) async {
    try {
      User? user =
          await _auth.signUpWithEmailAndPassword(model.email, model.password);
      if (user != null) {
        print("User is successfully created");
        final responseDb = await _dbService.createUser(
          uid: user.uid,
          user: UserModel(name: model.name, email: model.email, age: model.age),
        );
        if (responseDb.status) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginView(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unknown error occured. Please, try again later.'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unknown error occured. Please, try again later.'),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
