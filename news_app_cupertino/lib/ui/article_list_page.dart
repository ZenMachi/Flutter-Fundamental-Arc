import 'package:news_app/data/model/article.dart';
import 'package:news_app/ui/article_detail_page.dart';
import 'package:news_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  FutureBuilder<String> _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future:
      DefaultAssetBundle.of(context).loadString('assets/articles.json'),
      builder: (context, snapshot) {
        final List<Article> articles = parseArticles(snapshot.data);
        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return _buildArticleItem(context, articles[index]);
          },
        );
      },
    );
  }
}

Widget _buildArticleItem(BuildContext context, Article article) {
  return Material(
    child: ListTile(
      onTap: () {
        Navigator.pushNamed(context, ArticleDetailPage.routeName,
            arguments: article);
      },
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: article.urlToImage,
        child: Image.network(
          article.urlToImage,
          width: 100,
          errorBuilder: (ctx, error, _) =>
          const Center(
            child: Icon(Icons.error),
          ),
        ),
      ),
      title: Text(article.title),
      subtitle: Text(article.author),
    ),
  );
}