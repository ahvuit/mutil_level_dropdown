import 'package:flutter/material.dart';

typedef OnDropDownItemChanged<T> = Function(T);
typedef MapDropDownText<T> = Widget Function(T);

class MultiLevelDropDown<T> extends StatelessWidget {
  final List<Category<T>> categories;
  final OnDropDownItemChanged<T?> onDropDownItemChanged;
  final MapDropDownText<T> mapDropDownText;
  final T? selectedValue;
  final String hintText;

  const MultiLevelDropDown({
    super.key,
    required this.categories,
    required this.mapDropDownText,
    required this.onDropDownItemChanged,
    this.selectedValue,
    this.hintText = "Select an item",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context);
      },
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedValue != null
                ? selectedValue.toString()
                : hintText),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: categories.map((category) {
            return _buildCategoryItem(category);
          }).toList(),
        );
      },
    );
  }

  Widget _buildCategoryItem(Category<T> category) {
    if (category.subCategories.isNotEmpty) {
      return ExpansionTile(
        onExpansionChanged: (value) {
          onDropDownItemChanged(category.value);
        },
        title: Text(category.name),
        children: category.subCategories.map((subCategory) {
          return _buildCategoryItem(subCategory);
        }).toList(),
      );
    } else if (category.value != null) {
      return ListTile(
        title: Text(category.name),
        onTap: () {
          onDropDownItemChanged(category.value);
        },
      );
    } else {
      return ListTile(
        title: Text(category.name),
        onTap: () {
          onDropDownItemChanged(category.value);
        },
      );
    }
  }

}

class Category<T> {
  final String name;
  final T? value;
  final List<Category<T>> subCategories;

  Category({
    required this.name,
    this.value,
    this.subCategories = const [],
  });
}

class CategoryItem {
  final String name;
  CategoryItem(this.name);

  @override
  String toString() => name;
}