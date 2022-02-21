import '../database/helpers.dart';

class DatabaseRepository {
  DBHelper dbHelper = DBHelper();

  getDatabase() {
    return dbHelper.database;
  }

  insertBackground(String background) {
    return dbHelper.insertBackground(background);
  }

  getBackground() {
    return dbHelper.getBackground();
  }

  deleteBackground() {
    return dbHelper.deleteBackground();
  }

}