import 'package:daily/app/modules/emotions/http/tags_http.dart';
import 'package:daily/app/modules/ui/DailyButton.dart';
import 'package:daily/app/modules/ui/daily_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/domain/emotion.dart';
import '../../../core/domain/tags.dart';

class TagsEditBottomSheet extends StatefulWidget {
  final Emotion emotion;
  final PageController pageController;

  TagsEditBottomSheet({
    Key? key,
    required this.pageController,
    required this.emotion,
  });

  @override
  State<TagsEditBottomSheet> createState() => _EmotionAddBottomSheetState();
}

class _EmotionAddBottomSheetState extends State<TagsEditBottomSheet> {
  late List<Tags> tags = [];
  List<String> _selectedTags = [];

  @override
  void initState() {
    super.initState();
    _fetchTags();

    for (Tags tag in widget.emotion.tags!) {
      _selectedTags.add(tag.text);
    }
  }

  _fetchTags() async {
    List<Tags> fetchedTags = await TagsHttp().fetchTags();
    setState(() {
      tags = fetchedTags;
    });
  }

  _onClickTag(Tags tag) {
    setState(() {
      _selectedTags = List.from(_selectedTags);
      if (_selectedTags.contains(tag.text)) {
        _selectedTags.remove(tag.text);
      } else {
        _selectedTags.add(tag.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.9,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_outlined),
                    onPressed: () {
                      widget.pageController.previousPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut);
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              const Gap(16),
              const Text("O que está fazendo você se sentir assim?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'Pangram'),
                  textAlign: TextAlign.center),
              const Gap(16),
              Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: tags.map(
                    (tag) {
                      return GestureDetector(
                        onTap: () {
                          _onClickTag(tag);
                        },
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                              color: (_selectedTags.contains(tag.text)
                                  ? const Color.fromRGBO(158, 181, 103, 1)
                                  : Colors.white),
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  tag.emote,
                                  style: const TextStyle(
                                      fontSize: 32, fontFamily: 'Urbanist'),
                                ),
                                Text(tag.text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Pangram',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: _selectedTags.contains(tag)
                                            ? Colors.white
                                            : Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList()),
              const Gap(16),
              if (_selectedTags.isNotEmpty)
                DailyButton(
                    text: DailyText.text("Continuar").neutral,
                    onPressed: () {
                      List<Tags> finalTags = [];
                      for (int i = 0; i <= _selectedTags.length - 1; i++) {
                        for (Tags tag in tags) {
                          if (_selectedTags.elementAt(i) == tag.text) {
                            finalTags.add(tag);
                          }
                        }
                      }
                      widget.emotion.tags = finalTags;

                      widget.pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    }),
            ],
          ),
        ),
      ),
    );
  }
}
