import 'package:sqflite/sqflite.dart';

abstract class Migration {
  void crate(Batch batch);
  void update(Batch batch);
}
