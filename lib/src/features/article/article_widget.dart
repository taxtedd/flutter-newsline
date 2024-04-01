import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../general_news/news_loading_screen.dart';
import '../like/like_widget.dart';

class NewslineTile extends StatefulWidget {
  final String? imgUrl, title, desc, url;
  final bool setIsVisible;

  const NewslineTile(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.desc,
      required this.url,
      required this.setIsVisible});

  @override
  State<NewslineTile> createState() => _NewslineTileState();
}

class _NewslineTileState extends State<NewslineTile> {
  final likedNews = Hive.box('likedNews');
  bool isLiked = false;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    isVisible = true;
    isLiked = likedNews.get(widget.url) != null;
  }

  toggleLike() {
    if (isLiked) {
      likedNews.delete(widget.url);
      isVisible = widget.setIsVisible;
    } else {
      likedNews.put(widget.url, true);
    }
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsPageScreen(
                      articleUrl: widget.url!,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            if (isVisible) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(widget.imgUrl!),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.title!,
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                  LikeButton(isLiked: isLiked, onTap: toggleLike),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.desc!,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
