import 'package:flutter/material.dart';
import 'package:news_app/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'article.dart';

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
            Image.network(article.urlToImage),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.description),
                  const Divider(color: Colors.grey,),
                  Text(
                    article.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                  const Divider(color: Colors.grey,),
                  Text(
                    article.content,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ArticleWebView.routeName,
                            arguments: article.url);
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

class ArticleWebView extends StatelessWidget {
  static const routeName = '/article_web';

  final String url;

  const ArticleWebView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    return CustomScaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

