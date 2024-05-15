part of 'register_view.dart';

mixin RegisterMixin on State<RegisterView> {
  FirebaseDatabaseServices _dbService = FirebaseDatabaseServices();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _userNameController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController = TextEditingController();
    _ageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _ageController.dispose();
  }

  void handleBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }

  void handleRegister() {}
}
