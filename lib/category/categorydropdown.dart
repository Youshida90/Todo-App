// ignore_for_file: unused_field

import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:flutter/services.dart' as rootBundle;
import 'package:todo_app/category/category.dart';

class CategoryPage extends StatefulWidget {
  final Function(Category1?) onCategorySelected;
  const CategoryPage({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Category1> categories = [];
  final _searchController = TextEditingController();
  List<Category1> _suggestedCategories = [];

  @override
  void initState() {
    super.initState();
    _loadCategoryData();
  }

  void _loadCategoryData() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('lib/categoryjson/category.json');
    final list = json.decode(jsondata) as List<dynamic>;
    setState(() {
      categories = list.map((e) => Category1.fromJson(e)).toList();
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _suggestedCategories = categories
          .where((category) =>
              category.name.toLowerCase().contains(query))
          .toList();
    });
  }

void _showCategoryDialog() {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          final filteredCategories = categories
              .where((category) =>
                  category.name
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase()))
              .toList();
          return AlertDialog(
            title: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Category',
              ),
              onChanged: (value) {
                setState(
                    () {}); // Trigger a rebuild to update the filtered list
              },
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = filteredCategories[index];
                  return ListTile(
                    onTap: () {
                      _searchController.text = category.name;
                      Navigator.pop(context); // Close the dialog
                      widget.onCategorySelected(category);
                    },
                    leading: category.icon.isNotEmpty
                        ? Image.network(
                            category.icon,
                            width: 40,
                            errorBuilder: (context, error, stackTrace) =>
                               const Icon(Icons.error),
                          )
                        : null,
                    title: Text(category.name.toString()),
                  );
                },
              ),
            ),
          );
        },
      );
    },
  );
}

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _showCategoryDialog,
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search Category',
            ),
            onTap:
                _showCategoryDialog, // Show the dialog when tapping the TextField
          ),
        ),
      ],
    );
  }
}