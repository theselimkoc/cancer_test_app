part of 'home_view.dart';

mixin HomeMixin on State<HomeView> {
  FirebaseDatabaseServices _dbService = FirebaseDatabaseServices();
  void handleLogOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }

  void handleTest(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const TestView(),
      ),
    );
  }
}
