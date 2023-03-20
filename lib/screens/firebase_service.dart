import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> addUser(String name, String email, String phone) async {
    QuerySnapshot snapshot =
    await _db.collection('users').where('phone', isEqualTo: phone).get();

    if (snapshot.docs.isNotEmpty) {
      // User already exists, update data and return message
      DocumentReference docRef = snapshot.docs.first.reference;
      await docRef.update({
        'name': name,
        'email': email,
        'phone': phone,
      });
      return 'User updated successfully';
    } else {
      // User does not exist, add data and return message
      await _db.collection('users').add({
        'name': name,
        'email': email,
        'phone': phone,
      });
      return 'User added successfully';
    }
  }

}
