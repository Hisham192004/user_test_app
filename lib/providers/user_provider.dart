import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/models/user_model.dart';

enum AgeSortType { all, elder, younger }

class UserProvider extends ChangeNotifier {
  late Box<UserModel> _userBox;

  List<UserModel> _users = [];
  String _searchQuery = '';
  AgeSortType _ageSortType = AgeSortType.all;

  UserProvider() {
    _userBox = Hive.box<UserModel>('usersBox');
    loadUsers();
  }

  void loadUsers() {
    _users = _userBox.values.toList();
    notifyListeners();
  }

  void addUser(UserModel user) {
    _userBox.add(user);
    loadUsers();
  }

  void deleteUser(int index) {
    _userBox.deleteAt(index);
    loadUsers();
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void setAgeSort(AgeSortType type) {
    _ageSortType = type;
    notifyListeners();
  }

  AgeSortType get ageSortType => _ageSortType;

  List<UserModel> get filteredUsers {
    List<UserModel> result = List.from(_users);
    if (_searchQuery.isNotEmpty) {
      result = result.where((user) {
        return user.name
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            user.phone.contains(_searchQuery);
      }).toList();
    }
    if (_ageSortType == AgeSortType.elder) {
      result = result.where((u) => u.age >= 60).toList();
    } else if (_ageSortType == AgeSortType.younger) {
      result = result.where((u) => u.age < 60).toList();
    }

    return result;
  }
}
