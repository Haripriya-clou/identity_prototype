import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

Future<void> exportLocalDatabase() async {
  final box = Hive.box('users');

  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/users_backup.txt');

  file.writeAsStringSync(box.toMap().toString());
}