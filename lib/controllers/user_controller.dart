import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  CollectionReference _user_table =
      FirebaseFirestore.instance.collection('users');

  var user_details;

  get user => user_details;

  void addUser(user_details) async {
    await _user_table.doc(user_details['user_id']).set(user_details);
  }

  void getUserByUserId(String user_id) async {
    var query = await _user_table.where("user_id", isEqualTo: user_id).get();
    user_details = query.docs[0];
    update();
  }

  void updateUserGC(String code, user_id) async {
    var new_item = [code];
    var query = await _user_table.where("user_id", isEqualTo: user_id).get();
    _user_table
        .doc(query.docs[0]['user_id'])
        .update({"group_chats": FieldValue.arrayUnion(new_item)});
    getUserByUserId(user_id);
  }

  void getUserByEmail(String? email) async {
    var query = await _user_table.where("email", isEqualTo: email).get();
    user_details = query.docs[0];
    update();
  }
}
