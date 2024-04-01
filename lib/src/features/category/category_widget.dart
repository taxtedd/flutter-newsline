import 'package:flutter/material.dart';

import '../news_in_category/news_in_category_screen.dart';

class CategoryTile extends StatelessWidget {
  final String? categoryName;
  const CategoryTile({super.key, this.categoryName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsInCategoryScreen(
                      category: categoryName as String,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        width: 100,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black)),
        child: Text(categoryName!, style: theme.textTheme.labelSmall),
      ),
    );
  }
}
