import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:news_app/elements/article.dart';
import 'dart:convert';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> news = [];
  @override
  void initState() {
    fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter News App'),
      ),
      backgroundColor: Colors.grey,
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final article = news[index];
            final title = article['title'];
            final description = article['description'];
            final author = article['source']['name'];
            final publishDate = article['publishedAt'];
            final thumbnail = Image.network(article['urlToImage'],
                loadingBuilder: (BuildContext context, Widget body,
                    ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return body;
              }
              return Center(
                  child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ));
            });
            return CustomListItem(
                thumbnail: thumbnail,
                title: title,
                subtitle: description,
                author: author,
                publishDate: publishDate);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: news.length),
    );
  }

  void fetchNews() async {
    print('Okay');
    const url = 'https://mocki.io/v1/a3b52530-9ce3-4d02-b057-e59ef3aab339';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      news = json['articles'];
    });
    print('done');
  }
}
