import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key, required this.categories});

  final List<String> categories;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState(categories:categories);
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final List<String> categories;
  late String _selectedCategory;

  _CategoryWidgetState({required this.categories});

  @override
  void initState() {
    _selectedCategory = categories.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: false,
        physics: const ClampingScrollPhysics(),
        children: categories
            .map(
              (e) => GestureDetector(
                onTap: () => _selectCategory(e),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AnimatedDefaultTextStyle(
                    style: _selectedCategory == e
                        ? Theme.of(context).textTheme.titleLarge!
                        : Theme.of(context).textTheme.titleMedium!,
                    duration: const Duration(milliseconds: 200),
                    child: Text(e),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }
}
