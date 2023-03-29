import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        category,
      ),
    );
  }
}
