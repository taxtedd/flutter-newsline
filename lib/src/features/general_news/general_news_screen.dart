import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../article/article_widget.dart';
import '../category/category_list.dart';
import '../article/article_model.dart';
import '../category/category_widget.dart';
import '../category/category_model.dart';
import '../../data/news_list_request.dart';
import '../theme/theme_provider.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({
    super.key,
  });

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
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
    News newsList = News();
    await newsList.getNews();

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
        leading: IconButton(
          icon: Icon((theme.brightness == Brightness.light)
              ? Icons.dark_mode_outlined
              : Icons.light_mode_outlined),
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
        ),
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
                                setIsVisible: true,
                              )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
