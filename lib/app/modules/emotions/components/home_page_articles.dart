import 'dart:async';
import 'dart:convert';
import 'package:daily/app/modules/articles/services/articles_service.dart';
import 'package:daily/app/modules/ui/daily_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import '../../../core/domain/article.dart';

class HomePageArticles extends StatefulWidget {
  const HomePageArticles({super.key});

  @override
  State<HomePageArticles> createState() => _HomePageArticlesState();
}

class _HomePageArticlesState extends State<HomePageArticles> {
  int selectedIndex = 0;
  late Timer _timer;
  List<Article> articles = [];

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _populaNoticias();
    _avancarNoticia();
  }

  void _populaNoticias() async {
    List<Article> fetchedArticles = await ArticlesService().fetchLastArticles();

    setState(() {
      articles = fetchedArticles;
      selectedIndex = 0;
    });
  }

  void _avancarNoticia() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {
        if (articles.isNotEmpty) {
          selectedIndex = (selectedIndex + 1) % articles.length;
        }
      });
    });
  }

  void _lidaComArrastoNoticia(double velocity) {
    print(velocity);
    setState(() {
      if (articles.isNotEmpty) {
        if (velocity >= 0) {
          selectedIndex =
              (selectedIndex - 1 + articles.length) % articles.length;
        } else {
          selectedIndex = (selectedIndex + 1) % articles.length;
        }
      }
    });
  }

  String _decodeUtf8(String text) {
    return utf8.decode(text.codeUnits);
  }

  GestureDetector retornaContainerNoticia(int index) {
    if (articles.isEmpty) return GestureDetector();

    return GestureDetector(
      onTap: () {
        Modular.to.navigate('/articles/details?isFromList=false', arguments: articles[index]);
      },
      onHorizontalDragEnd: (details) {
        _lidaComArrastoNoticia(details.primaryVelocity!);
      },
      child: Container(
        height: 140,
        width: 358,
        decoration: BoxDecoration(
          color: index == 0
              ? const Color.fromRGBO(158, 181, 103, 1)
              : index == 1
              ? const Color.fromRGBO(210, 151, 0, 1)
              : const Color.fromRGBO(131, 180, 255, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              alignment: Alignment.center,
              height: 150,
              width: 177,
              child: DailyText.text(_decodeUtf8(articles.elementAt(index).title))
                  .header
                  .small
                  .bold
                  .neutral,
            ),
            Image.asset(
              index == 0
                  ? "assets/article_illustration.png"
                  : index == 1
                  ? "assets/article_illustration2.png"
                  : "assets/article_illustration3.png",
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (articles.isNotEmpty) retornaContainerNoticia(selectedIndex),
        const Gap(9),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < articles.length; i++) ...[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (selectedIndex == i)
                      ? Colors.black87
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
                width: 8,
                height: 8,
              ),
              const Gap(5)
            ]
          ],
        ),
      ],
    );
  }
}
