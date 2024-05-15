// ignore_for_file: use_build_context_synchronously

import 'package:cancer_test_app/components/colon_title.dart';
import 'package:cancer_test_app/components/custom_text_field.dart';
import 'package:cancer_test_app/components/general_container.dart';
import 'package:cancer_test_app/constants/paddings.dart';
import 'package:cancer_test_app/constants/user.dart';
import 'package:cancer_test_app/views/auth/register_view/register_view.dart';
import 'package:cancer_test_app/views/home_view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'login_mixin.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginMixin {
  Future<void> logIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (user.user != null) {
        CUser.uid = user.user!.uid;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: CPaddings.contentPadding,
        child: Center(
          child: GeneralContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: Colors.blue,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.person,
                        size: 100,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const ColonTitle(data: "E-mail:"),
                CustomTextField(
                  controller: emailController,
                  hintText: "E-mail adresinizi giriniz",
                ),
                const SizedBox(height: 10),
                const ColonTitle(data: "Parola:"),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Enter your password",
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Hesabınız yok mu?"),
                    TextButton(
                      onPressed: handleRegister,
                      child: const Text("Kayıt ol"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : logIn,
                  child: isLoading
                      ? CircularProgressIndicator.adaptive()
                      : const Text('Giriş Yap'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
