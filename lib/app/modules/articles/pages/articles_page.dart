import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../core/domain/article.dart';
import '../../emotions/components/daily_drawer.dart';
import '../../ui/daily_bottom_navigation_bar.dart';
import '../../ui/daily_text.dart';
import '../services/articles_service.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    _populaNoticias();
  }

  Future<void> _populaNoticias() async {
    List<Article> fetchedArticles = await ArticlesService().fetchLastArticles();
    setState(() {
      articles = fetchedArticles;
    });
  }

  String _decodeUtf8(String text) {
    return utf8.decode(text.codeUnits);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DailyDrawer(),
      bottomNavigationBar: const DailyBottomNavigationBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Builder(
                      builder: (context) {
                        return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu_outlined,
                            size: 30,
                          ),
                        );
                      },
                    ),
                    DailyText.text("Artigos").header.medium.bold,
                    IconButton(
                      onPressed: () {
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Modular.to.navigate('/articles/details?isFromList=true', arguments: articles[index]);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                        image: DecorationImage(
                          image: NetworkImage(article.bannerURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Container(
                              width: 370,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _decodeUtf8(article.title),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Pangram',
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    DateFormat('dd/MM/yy').format(article.creationDate),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
