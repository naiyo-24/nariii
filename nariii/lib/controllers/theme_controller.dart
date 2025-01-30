import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final _key = 'isDarkMode';
  
  final _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromStorage();
  }

  void _loadThemeFromStorage() {
    final savedTheme = _storage.read(_key);
    if (savedTheme != null) {
      _isDarkMode.value = savedTheme;
      _applyTheme();
    }
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    _storage.write(_key, _isDarkMode.value);
    _applyTheme();
  }

  void _applyTheme() {
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
