import 'package:flutter/material.dart';
import 'package:flutter_task1/features/news_in_category/news_in_category_screen.dart';
import 'package:flutter_task1/features/news_page/news_page_screen.dart';
import 'package:flutter_task1/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import '../../models/article_model.dart';
import '../../models/category_model.dart';
import 'news_list.dart';

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
          icon: const Icon(Icons.dark_mode_outlined),
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
                              )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

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

class NewslineTile extends StatelessWidget {
  final String? imgUrl, title, desc, url;

  const NewslineTile(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.desc,
      required this.url});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsPageScreen(
                      articleUrl: url!,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imgUrl!),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title!,
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              desc!,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
