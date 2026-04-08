import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

Future<void> syncLocalToFirebase() async {
  final box = Hive.box('users');

  for (var key in box.keys) {
    var data = box.get(key);

    if (data['synced'] == false) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(key)
            .set(data);

        data['synced'] = true;
        box.put(key, data);
      } catch (_) {}
    }
  }
}