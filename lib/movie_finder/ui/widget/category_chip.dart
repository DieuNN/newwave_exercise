import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip(
      {Key? key, required this.category, this.onChipTap, })
      : super(key: key);
  final String category;
  final VoidCallback? onChipTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChipTap,
      child: Chip(
        label: Text(
          category,
        ),
      ),
    );
  }
}
