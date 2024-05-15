import 'package:cancer_test_app/constants/user.dart';
import 'package:cancer_test_app/models/response_model.dart';
import 'package:cancer_test_app/models/user/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseServices {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  Future<ResponseModel> createUser({
    required String uid,
    required UserModel user,
  }) async {
    try {
      await dbRef.child('users').child(uid).set(user.toJson());
      return ResponseModel(
        status: true,
        message: 'success',
      );
    } catch (e) {
      print(e);
      return ResponseModel(
        status: false,
        message: e.toString(),
      );
    }
  }

  Future<ResponseModel<UserModel?>> getUser({required String uid}) async {
    try {
      final snapshot = await dbRef.child('users/$uid').get();
      if (snapshot.exists) {
        print('Snapshot Data: ${snapshot.value}');
        final Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);

        CUser.age = int.parse(data['age']);
        return ResponseModel(
          status: true,
          data: UserModel.fromJson(data),
        );
      }
      return ResponseModel(
        status: false,
        message: 'error',
      );
    } catch (e) {
      print('Get User Error: $e');
      return ResponseModel(
        status: false,
        message: e.toString(),
      );
    }
  }
}
