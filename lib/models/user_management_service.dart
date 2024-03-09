import 'package:flutter/material.dart';
import 'package:nekoflixx/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManagementService extends ChangeNotifier {
  final List<User> _users = [];

  List<User> get users => _users;

  Future<void> addUser(User user) async {
    _users.add(user);
    await _saveUser(user);
    notifyListeners();
    print('User added: ${user.userName}');
  }

  Future<void> _saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(user.userName, user.password);
    print('User saved to storage: ${user.userName}');
  }

  Future<void> loadUsersFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getKeys().toList();
    _users.clear();
    for (var key in keys) {
      String? password = prefs.getString(key);
      if (password != null) {
        _users.add(User(userName: key, password: password));
        print('User loaded from storage: $key');
      }
    }
    notifyListeners();
  }

  bool userExist(String username) {
    return _users.any((user) => user.userName == username);
  }

  bool validatePassword(String username, String password) {
    var user = _users.firstWhere((user) => user.userName == username,
        orElse: () => User(userName: '', password: ''));
    return user.password == password;
  }

  // Add other methods as needed, like fetching users from local storage, etc.
}
