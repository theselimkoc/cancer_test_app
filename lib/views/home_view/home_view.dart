import 'package:cancer_test_app/components/general_container.dart';
import 'package:cancer_test_app/components/risk_status.dart';
import 'package:cancer_test_app/constants/paddings.dart';
import 'package:cancer_test_app/constants/user.dart';
import 'package:cancer_test_app/models/response_model.dart';
import 'package:cancer_test_app/models/user/user_model.dart';
import 'package:cancer_test_app/services/firebase_database_services.dart';
import 'package:cancer_test_app/views/auth/login_view/login_view.dart';
import 'package:cancer_test_app/views/test_view/test_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'home_mixin.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => handleLogOut(context),
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Hoş geldiniz",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
          future: _dbService.getUser(
            uid: CUser.uid!,
          ),
          builder: (context, snapshotUser) {
            if (!snapshotUser.hasData) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshotUser.hasError ||
                snapshotUser.error != null ||
                (snapshotUser.data != null && !snapshotUser.data!.status)) {
              return Center(
                child: Text('Unknown error occured. Please, try again later.'),
              );
            }
            final responseUser = snapshotUser.data as ResponseModel<UserModel?>;
            return _buildContent(context, responseUser.data!);
          }),
    );
  }

  Padding _buildContent(BuildContext context, UserModel user) {
    return Padding(
      padding: CPaddings.contentPadding,
      child: Column(
        children: [
          _personInfoSection(context, user),
          const SizedBox(height: 20),
          _riskSection(context),
        ],
      ),
    );
  }

  GeneralContainer _personInfoSection(BuildContext context, UserModel user) {
    return GeneralContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Adınız: ${user.name}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            "Yaşınız: ${user.age}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            "E-mail Adresiniz: ${user.email}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  GeneralContainer _riskSection(BuildContext context) {
    return GeneralContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Kanser Riskiniz:",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.blue),
          ),
          Divider(
            color: Colors.blue.withOpacity(0.25),
          ),
          const SizedBox(height: 10),
          const RiskStatus(
            riskDegree: 65,
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => handleTest(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check),
                    SizedBox(width: 5),
                    Text("Yeni test yapınız"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
