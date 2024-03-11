import 'package:flutter/material.dart';
import 'package:flutter_task1/features/news_list/news_list.dart';
import '../../models/article_model.dart';
import '../../models/category_model.dart';
import '../news_list/news_list_screen.dart';

class NewsInCategoryScreen extends StatefulWidget {
  final String category;

  const NewsInCategoryScreen({super.key, required this.category});

  @override
  State<NewsInCategoryScreen> createState() => _NewsInCategoryScreenState();
}

class _NewsInCategoryScreenState extends State<NewsInCategoryScreen> {
  late final List<CategoryModel> categories;
  late final List<ArticleModel> articles;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    NewsInCategory newsList = NewsInCategory();
    await newsList.getNewsInCategory(widget.category);

    articles = newsList.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text('News', style: theme.textTheme.labelLarge),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      height: 70,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) => CategoryTile(
                                categoryName: categories[index].categoryName,
                              )),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) => NewslineTile(
                                imgUrl: articles[index].urlToImage,
                                title: articles[index].title,
                                desc: articles[index].description,
                                url: articles[index].url,
                              )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
