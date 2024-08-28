import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../core/domain/account.dart';
import '../../../core/domain/meditation.dart';
import '../../../core/domain/providers/account_provider.dart';
import '../../ui/daily_text.dart';
import 'package:http/http.dart' as http;

class MeditationPlayPage extends StatefulWidget {
  final Meditation currentMeditation;

  const MeditationPlayPage({super.key, required this.currentMeditation});

  @override
  State<MeditationPlayPage> createState() => _MeditationPlayPageState();
}

class _MeditationPlayPageState extends State<MeditationPlayPage>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initializeAudio();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    completeMeditationGoal();
  }

  Future<void> completeMeditationGoal() async {
    Account? account =
        Provider.of<AccountProvider>(context, listen: false).account;

    List<String> completedGoals = account?.completedGoals ?? [];

    if (!completedGoals.contains('meditar')) {
      completedGoals.add('meditar');

      final response = await http.put(
        Uri.parse(
            'http://10.0.2.2:8080/api/v1/account/goals?goal=meditar&userId=${account!.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    }
    if (!completedGoals.contains('meta')) {
      completedGoals.add('meta');

      final secondResponse = await http.put(
        Uri.parse(
            'http://10.0.2.2:8080/api/v1/account/goals?goal=meta&userId=${account!.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    }

    account?.completedGoals = completedGoals;
  }

  void _initializeAudio() async {
    if (widget.currentMeditation.audioFile.isNotEmpty) {
      await _audioPlayer
          .setSource(AssetSource(widget.currentMeditation.audioFile));
      _audioPlayer.onDurationChanged.listen((Duration duration) {
        setState(() {
          _totalDuration = duration;
        });
      });
      _audioPlayer.onPositionChanged.listen((Duration position) {
        setState(() {
          _currentPosition = position;
        });
      });
      await _audioPlayer.setVolume(1);
      await _audioPlayer.resume();
      setState(() {
        _isPlaying = true;
      });
    }
  }

  void _pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  void _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  void _resumeAudio() async {
    await _audioPlayer.resume();
    setState(() {
      _isPlaying = true;
    });
  }

  void _seekAudio(double value) {
    final position = Duration(milliseconds: value.toInt());
    _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  String _decodeUtf8(String text) {
    return utf8.decode(text.codeUnits);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blueGrey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                              Modular.to.navigate('/meditation/details',
                                  arguments: widget.currentMeditation);
                              _stopAudio();
                            },
                            icon: const Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          );
                        },
                      ),
                      const Gap(20),
                    ],
                  ),
                  DailyText.text(_decodeUtf8(widget.currentMeditation.name))
                      .neutral
                      .header
                      .medium
                      .bold,
                  const Gap(150),
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: Container(
                      alignment: Alignment.center,
                      width: 270,
                      height: 270,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          shape: BoxShape.circle),
                      child: Text(_formatDuration(_currentPosition),
                          style: const TextStyle(
                              fontFamily: 'Pangram',
                              fontSize: 30,
                              color: Colors.white)),
                    ),
                  ),
                  const Gap(100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _formatDuration(_currentPosition),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Expanded(
                        child: Slider(
                          value: (_currentPosition.inMilliseconds.toDouble())
                              .clamp(
                                  0, _totalDuration.inMilliseconds.toDouble()),
                          min: 0,
                          max: _totalDuration.inMilliseconds.toDouble(),
                          onChanged: (value) {
                            _seekAudio(value);
                          },
                          activeColor: const Color.fromRGBO(158, 181, 103, 1),
                          inactiveColor: Colors.grey,
                        ),
                      ),
                      Text(
                        _formatDuration(_totalDuration),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(240, 240, 240, .4),
                        shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: _isPlaying ? _pauseAudio : _resumeAudio,
                      icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
