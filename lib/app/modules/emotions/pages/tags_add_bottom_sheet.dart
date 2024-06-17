import 'package:daily/app/modules/emotions/http/tags_http.dart';
import 'package:daily/app/modules/ui/DailyButton.dart';
import 'package:daily/app/modules/ui/daily_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/domain/emotion.dart';
import '../../../core/domain/tags.dart';

class TagsAddBottomSheet extends StatefulWidget {
  final Emotion emotion;
  final PageController pageController;

  TagsAddBottomSheet({Key? key, required this.pageController, required this.emotion, });

  @override
  State<TagsAddBottomSheet> createState() => _EmotionAddBottomSheetState();
}

class _EmotionAddBottomSheetState extends State<TagsAddBottomSheet> {
  late List<Tags> tags = [];
  List<Tags> _selectedTags = [];

  @override
  void initState() {
    super.initState();
    _fetchTags();
  }

  _fetchTags() async {
    List<Tags> fetchedTags = await TagsHttp().fetchTags();
    setState(() {
      tags = fetchedTags;
    });
  }

  _onClickTag(Tags tag) {
    setState(() {
      _selectedTags.contains(tag)
          ? _selectedTags.remove(tag)
          : _selectedTags.add(tag);
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 32,
                      ))
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
                              color: (_selectedTags.contains(tag)
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

                      widget.emotion.tags = _selectedTags;

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
