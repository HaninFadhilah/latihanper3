import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

enum ViewState { initial, loading, loaded, empty, error }

class DataProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  // Menyimpan state data
  ViewState _state = ViewState.initial;
  List<UserModel> _users = [];
  String _errorMessage = '';

  ViewState get state => _state;
  List<UserModel> get users => _users;
  String get errorMessage => _errorMessage;

  Future<void> loadUsers({String? token}) async {
    // Ubah state menjadi loading
    _state = ViewState.loading;
    notifyListeners();

    try {
      // Ambil data users dari API
      final users = await _apiService.fetchUsers(token: token);

      _users = users;

      // Cek apakah data kosong
      if (_users.isEmpty) {
        _state = ViewState.empty;
      } else {
        _state = ViewState.loaded;
      }
    } catch (e) {
      // Jika terjadi error
      _errorMessage = e.toString();
      _state = ViewState.error;
    }

    // Beritahu UI bahwa state sudah berubah
    notifyListeners();
  }
}