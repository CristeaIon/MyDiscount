import 'package:hive/hive.dart';

import '../domain/entities/user_model.dart';
import '../domain/repositories/user_hive_repo.dart';

class HiveUserRepoImpl implements HiveUserRepository {
  final HiveInterface hive;

  HiveUserRepoImpl(this.hive);
  @override
  void deleteLocalUser() async {
    final userBox = await _openBox('user');
    await userBox.delete(1);
  }

  @override
  Future<User> getLocalUser() async {
    final userBox = await _openBox('user');
    final user = userBox.get(1);
    return user;
  }

  @override
  Future<User> saveLocalUser(User user) async {
    try {
      final userBox = await _openBox('user');
      await userBox.put(1, user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<Box<User>> _openBox(String type) async {
    try {
      final box = await hive.openBox(type);
      return box;
    } catch (e) {
      rethrow;
    }
  }
}
