import 'package:flutter/material.dart';

import 'DoctorCategory.dart';

class DoctorCategoryScreen extends StatefulWidget {
  @override
  _DoctorCategoryScreenState createState() => _DoctorCategoryScreenState();
}

class _DoctorCategoryScreenState extends State<DoctorCategoryScreen> {
  String _searchTerm = '';
  List<DoctorCategory> _categories = []; // Replace with your data source

  List<DoctorCategory> _filteredCategories() {
    if (_searchTerm.isEmpty) {
      return _categories;
    }
    return _categories
        .where((category) =>
            category.name.toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _filteredCategories().length,
        itemBuilder: (context, index) {
          final category = _filteredCategories()[index];
          return ListTile(
            title: Text(category.name),
            // Add more UI elements as needed
          );
        },
      ),
    );
  }
}
