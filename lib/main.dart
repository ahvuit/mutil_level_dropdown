import 'package:flutter/material.dart';

import 'mutil_level_dropdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text("Multi-Level Dropdown Example")),
          body: MultiLevelDropDown<String>(
            categories: [
              Category(
                name: 'Category 1',
                subCategories: [
                  Category(name: 'Subcategory 1-1', value: 'Item 1-1'),
                  Category(name: 'Subcategory 1-2', value: 'Item 1-2'),
                ],
                value: 'Item 1',
              ),
              Category(
                name: 'Category 2',
                subCategories: [
                  Category(name: 'Subcategory 2-1', value: 'Item 2-1'),
                  Category(
                    name: 'Subcategory 2-2',
                    subCategories: [
                      Category(name: 'Subcategory 2-2-1', value: 'Item 2-2-1'),
                    ],
                    value: 'Item 2-2',
                  ),
                ],
                value: 'Item 2',
              ),
            ],
            mapDropDownText: (String item) => Text(item),
            onDropDownItemChanged: (item) {
              print('Selected $item');
            },
            hintText: "Select an item",
          )),
    );
  }
}
