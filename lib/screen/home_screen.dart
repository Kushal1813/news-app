import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:news_app/elements/article.dart';
import 'package:news_app/elements/article_new.dart';
import 'dart:convert';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> news = [];
  bool _isLoading = true;
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
      backgroundColor: Colors.white,
      body: _isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.white,
              child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 16),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 96,
                      child: Row(
                        children: [
                          Container(
                            height: 96,
                            width: 96,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                    );
                  }))
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                final article = news[index];
                final title = article['title'];
                final description = article['description'];
                final author = article['source']['name'];
                final publishDate = article['publishedAt'];
                final thumbnail = article['urlToImage'];
                return Article(
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
    const url = 'https://mocki.io/v1/a3b52530-9ce3-4d02-b057-e59ef3aab339';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    await Future.delayed(const Duration(seconds: 3));
    if (response.statusCode == 200) {
      _isLoading = false;
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        news = json['articles'];
      });
    } else {
      throw Exception('HTTP failed');
    }
  }
}
