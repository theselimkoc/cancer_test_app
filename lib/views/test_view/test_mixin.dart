part of 'test_view.dart';

mixin TestMixin on State<TestView> {
  List<String> questions = [
    "Aile geçmişinizde kanser var mı",
    "Tütün kullanıyor musunuz",
    "Alkol tüketiyor musunuz",
    "Düzenli egzersiz yapar mısınız",
    "Obezite sorununuz var mı",
    "Ağrınız var mı",
    "Yorgunluk hissediyor musunuz",
    "İştah kaybı yaşıyor musunuz",
    "Kilo kaybı yaşıyor musunuz",
    "Solunum sorunları yaşıyor musunuz",
    "Öksürüğünüz var mı",
    "Sarılık belirtileri yaşıyor musunuz",
    "Cilt değişiklikleri fark ettiniz mi",
    "Kanama yaşıyor musunuz",
    "Görme problemleriniz var mı",
    "Baş ağrınız var mı",
    "Cinsel fonksiyon bozukluğunuz var mı"
  ];

  List<bool> answers = [];

  @override
  void initState() {
    for (var i = 0; i < questions.length; i++) {
      answers.add(false);
    }
    super.initState();
  }

  void handleBack(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }

  void handleTest() {
    List<dynamic> willSendAnswer = [CUser.age, ...answers];
    for (int i = 1; i < willSendAnswer.length; i++) {
    // Eğer değer false ise 0 yap, true ise 1 yap
    if (willSendAnswer[i] == false) {
      willSendAnswer[i] = 0;
    } else {
      willSendAnswer[i] = 1;
    }
  }
    print('Verileri bu şekilde gönderecek: ${willSendAnswer}');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }
}
