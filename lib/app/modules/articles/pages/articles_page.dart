import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
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
  List<Article> allArticles = [];
  List<Article> filteredArticles = [];
  bool isAll = true;
  bool isHealth = false;
  bool isStress = false;
  bool isRelationship = false;
  bool isAnxiety = false;

  @override
  void initState() {
    super.initState();
    _populaNoticias();
  }

  Future<void> _populaNoticias() async {
    List<Article> fetchedArticles = await ArticlesService().fetchAllArticles();
    setState(() {
      allArticles = fetchedArticles;
      _filterArticles();
    });
  }

  String _decodeUtf8(String text) {
    return utf8.decode(text.codeUnits);
  }

  void _filterArticles() {
    setState(() {
      if (isAll) {
        filteredArticles = allArticles;
      } else if (isHealth) {
        filteredArticles = allArticles
            .where((article) => article.category == 'saude')
            .toList();
      } else if (isStress) {
        filteredArticles = allArticles
            .where((article) => article.category == 'stress')
            .toList();
      } else if (isRelationship) {
        filteredArticles = allArticles
            .where((article) => article.category == 'relacoes')
            .toList();
      } else if (isAnxiety) {
        filteredArticles = allArticles
            .where((article) => article.category == 'ansiedade')
            .toList();
      }

      filteredArticles.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    });
  }


  void _selectCategory(String category) {
    setState(() {
      isAll = category == 'All';
      isHealth = category == 'Health';
      isStress = category == 'Stress';
      isRelationship = category == 'Relationship';
      isAnxiety = category == 'Anxiety';

      _filterArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DailyDrawer(),
      bottomNavigationBar: const DailyBottomNavigationBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 16.0, right: 16.0, bottom: 5),
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
                    Container(width: 40),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryButton('Todas Notícias', isAll, 'All'),
                _buildCategoryButton('Saúde', isHealth, 'Health'),
                _buildCategoryButton('Stress', isStress, 'Stress'),
                _buildCategoryButton(
                    'Relações', isRelationship, 'Relationship'),
                _buildCategoryButton('Ansiedade', isAnxiety, 'Anxiety'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredArticles.length,
              itemBuilder: (context, index) {
                final article = filteredArticles[index];
                return GestureDetector(
                  onTap: () {
                    Modular.to.navigate('/articles/details?isFromList=true',
                        arguments: article);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 16.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              article.bannerURL,
                              width: 120,
                              height: 110,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 120,
                                  height: 110,
                                  color: Colors.white,
                                  child: const Icon(Icons.broken_image, color: Colors.grey, size: 60),
                                );
                              },
                            ),
                          ),
                          const Gap(10),
                          SizedBox(
                            width: 230,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(_decodeUtf8(article.title),
                                    style: const TextStyle(
                                        fontFamily: 'Pangram',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                Text(article.minutesToRead)
                              ],
                            ),
                          ),
                          const Icon(Icons.more_vert)
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

  Widget _buildCategoryButton(String title, bool isSelected, String category) {
    return Padding(
      padding:
          EdgeInsets.only(left: category == 'All' ? 16.0 : 4.0, right: 6.0),
      child: GestureDetector(
        onTap: () => _selectCategory(category),
        child: Container(
          alignment: Alignment.center,
          height: 42,
          decoration: BoxDecoration(
            border: isSelected ? null : Border.all(color: Colors.grey),
            color: isSelected ? const Color.fromRGBO(158, 181, 103, 1) : null,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontFamily: 'Pangram',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
