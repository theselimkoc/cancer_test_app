import 'package:cancer_test_app/views/auth/login_view/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAk9gvi56SrNlkHNtt2KRG7-mRnmeDqoc8",
            authDomain: "cancer-app-8fe39.firebaseapp.com",
            projectId: "cancer-app-8fe39",
            storageBucket: "cancer-app-8fe39.appspot.com",
            messagingSenderId: "155022823815",
            appId:
                "1:155022823815:web:b466847a949c086341c322")); // Firebase'i başlatın
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAk9gvi56SrNlkHNtt2KRG7-mRnmeDqoc8",
            authDomain: "cancer-app-8fe39.firebaseapp.com",
            projectId: "cancer-app-8fe39",
            storageBucket: "cancer-app-8fe39.appspot.com",
            messagingSenderId: "155022823815",
            appId: "1:155022823815:web:b466847a949c086341c322"));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanser Testi Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
      home: const LoginView(),
    );
  }
}
