import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DoctorCategory.dart';

class DoctorService with ChangeNotifier {
  //List<Category> get categories => categories;
  final Dio _dio = Dio();

  //hive
  Future<void> saveDataLocally(List<DoctorCategory> data) async {
    final box = await Hive.openBox<DoctorCategory>('categories');
    await box.clear(); // Clear existing data (optional)
    box.addAll(data);
  }

  Future<List<DoctorCategory>> fromJson() async {
    final box = await Hive.openBox<DoctorCategory>('categories');
    return box.values.toList();
  }

  void fetchDataAndSaveLocally() async {
    try {
      final data = await fromJson(); // Fetch data from API
      await saveDataLocally(data); // Save data to local storage using Hive
      print('Data fetched from API and saved to local storage');
    } catch (e) {
      print('Error: $e');
    }
  }
  //hive

  Future<List<DoctorCategory>> fetchDoctorCategories() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200) {
        final data = response.data as List;
        prefs.setString('categories', data.toString());
        return data.map((item) => DoctorCategory.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load doctor categories');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  notifyListeners();
}
