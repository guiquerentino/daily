import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

import '../../../core/domain/test.dart';
import '../../emotions/components/daily_drawer.dart';
import '../../ui/daily_bottom_navigation_bar.dart';
import '../../ui/daily_text.dart';
import 'package:http/http.dart' as http;

class TestsPage extends StatefulWidget {
  const TestsPage({super.key});

  @override
  State<TestsPage> createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  bool isAll = true;
  bool isPopular = false;
  bool isPersonality = false;
  bool isMentalHealth = false;
  bool isPersonalGrowth = false;
  List<Test> tests = [];

  @override
  void initState() {
    super.initState();
    fetchTests();
  }

  Future<void> fetchTests() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/api/v1/tests'));

    if (response.statusCode == 200) {
      final List<dynamic> testsJson = json.decode(response.body);
      setState(() {
        tests = testsJson.map((json) => Test.fromJson(json)).toList();
      });
    }
  }

  void _selectCategory(String category) {
    setState(() {
      isAll = category == 'All';
      isPopular = category == 'Popular';
      isPersonality = category == 'Personality';
      isMentalHealth = category == 'MentalHealth';
      isPersonalGrowth = category == 'PersonalGrowth';
    });
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

  String _decodeUtf8(String text) {
    return utf8.decode(text.codeUnits);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DailyDrawer(),
        bottomNavigationBar: const DailyBottomNavigationBar(),
        body: Padding(
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
                  DailyText.text("Testes").header.medium.bold,
                  Container(width: 40),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryButton('Todos', isAll, 'All'),
                    _buildCategoryButton('Popular', isPopular, 'Popular'),
                    _buildCategoryButton(
                        'Personalidade', isPersonality, 'Personality'),
                    _buildCategoryButton(
                        'Saúde Mental', isMentalHealth, 'MentalHealth'),
                    _buildCategoryButton('Crescimento pessoal',
                        isPersonalGrowth, 'PersonalGrowth'),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tests.length,
                  itemBuilder: (context, index) {
                    final test = tests[index];
                    return GestureDetector(
                      onTap: () {
                        Modular.to.navigate('/tests/details',
                            arguments: test);
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
                                  test.bannerUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Gap(10),
                              SizedBox(
                                width: 210,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(_decodeUtf8(test.title),
                                        style: const TextStyle(
                                            fontFamily: 'Pangram',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    const Text('5 min')
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
              )
            ],
          ),
        ));
  }
}
