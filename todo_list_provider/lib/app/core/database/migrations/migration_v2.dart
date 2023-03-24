import 'package:sqflite/sqflite.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration.dart';

class MigrationV2 implements Migration {
  @override
  void crate(Batch batch) {
    batch.execute('create table teste(id integer)');
  }

  @override
  void update(Batch batch) {
    batch.execute('create table teste(id integer)');
  }
}
