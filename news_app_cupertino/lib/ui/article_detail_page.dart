import 'package:flutter/material.dart';
import 'package:news_app/common/navigation.dart';
import 'package:news_app/ui/article_web_view.dart';


import '../data/model/article.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: article.urlToImage!,
                child: Image.network(article.urlToImage!)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.description ?? ""),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    article.title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    'Date: ${article.publishedAt}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Author: ${article.author}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Divider(color: Colors.grey,),
                  Text(
                    article.content ?? "",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        Navigation.intentWithData(ArticleWebView.routeName, article.url);
                      },
                      child: const Text('Read More'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


