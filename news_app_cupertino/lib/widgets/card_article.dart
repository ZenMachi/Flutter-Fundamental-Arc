import 'package:flutter/material.dart';
import 'package:news_app/common/navigation.dart';
import 'package:news_app/provider/database_provider.dart';
import 'package:provider/provider.dart';

import '../common/styles.dart';
import '../data/model/article.dart';
import '../ui/article_detail_page.dart';

class CardArticle extends StatelessWidget {
  final Article article;

  const CardArticle({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: provider.isBookmarked(article.url),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              color: primaryColor,
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                trailing: isBookmarked
                    ? IconButton(
                  icon: const Icon(Icons.bookmark),
                  color: Theme.of(context).colorScheme.tertiary,
                  onPressed: () => provider.removeBookmark(article.url),
                )
                    : IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  color: Theme.of(context).colorScheme.tertiary,
                  onPressed: () => provider.addBookmark(article),
                ),
                leading: Hero(
                  tag: article.urlToImage!,
                  child: Image.network(
                    article.urlToImage!,
                    width: 100,
                  ),
                ),
                title: Text(
                  article.title,
                ),
                subtitle: Text(article.author ?? ""),
                onTap: () => Navigation.intentWithData(ArticleDetailPage.routeName, article)
              ),
            );
          }
        );
      }
    );
  }
}