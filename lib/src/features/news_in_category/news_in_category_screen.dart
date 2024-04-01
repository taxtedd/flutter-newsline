import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../article/article_widget.dart';
import '../../data/news_list_request.dart';
import '../article/article_model.dart';

class NewsInCategoryScreen extends StatefulWidget {
  final String category;

  const NewsInCategoryScreen({super.key, required this.category});

  @override
  State<NewsInCategoryScreen> createState() => _NewsInCategoryScreenState();
}

class _NewsInCategoryScreenState extends State<NewsInCategoryScreen> {
  late final List<ArticleModel> articles;
  final likedNews = Hive.box('likedNews');
  bool categoryIsLiked = false;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categoryIsLiked = widget.category == 'Liked';
    getNews();
  }

  getNews() async {
    NewsInCategory newsList = NewsInCategory();

    if (categoryIsLiked) {
      await newsList.getNewsInCategory('General');
      articles = newsList.news
          .where((element) => likedNews.get(element.url) != null)
          .toList();
    } else {
      await newsList.getNewsInCategory(widget.category);
      articles = newsList.news;
    }

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
                    if (categoryIsLiked && articles.isEmpty) ...[
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: Text(
                        'There is not any liked news',
                        style: theme.textTheme.labelMedium,
                      )),
                    ],
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
                                setIsVisible: categoryIsLiked ? false : true,
                              )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
