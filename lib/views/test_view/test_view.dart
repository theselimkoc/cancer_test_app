import 'package:cancer_test_app/components/general_container.dart';
import 'package:cancer_test_app/constants/paddings.dart';
import 'package:cancer_test_app/constants/user.dart';
import 'package:cancer_test_app/views/home_view/home_view.dart';
import 'package:flutter/material.dart';

part 'test_mixin.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> with TestMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => handleBack(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Kanser Riski Hesaplama Testi",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: CPaddings.contentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              ListView.builder(
                itemCount: questions.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => _questionContainer(
                  question: questions[index],
                  index: index,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: handleTest,
                child: const Text("Testi Bitir"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _questionContainer({
    required String question,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GeneralContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Soru: $question?",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            OptionComponent(
              index: index,
              answers: answers,
            ),
          ],
        ),
      ),
    );
  }
}

class OptionComponent extends StatefulWidget {
  OptionComponent({
    super.key,
    required this.index,
    required this.answers,
  });
  final int index;
  final List<bool> answers;
  @override
  State<OptionComponent> createState() => _OptionComponentState();
}

List<String> options = ['Evet', 'Hayır'];

class _OptionComponentState extends State<OptionComponent> {
  String selectedAnswer = options[1];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: options.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => RadioListTile(
        value: options[index],
        title: Text(options[index]),
        groupValue: selectedAnswer,
        onChanged: (String? value) {
          value = value ?? 'Hayır';
          setState(() {
            selectedAnswer = options[value == 'Evet' ? 0 : 1];
            widget.answers[widget.index] = value == 'Evet' ? true : false;
          });
        },
      ),
    );
  }
}
