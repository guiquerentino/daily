import 'dart:async';
import 'dart:convert';
import 'package:daily/app/core/domain/chat_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../core/domain/account.dart';
import '../../../core/domain/providers/account_provider.dart';
import '../../emotions/components/daily_drawer.dart';
import '../../ui/daily_app_bar.dart';
import '../../ui/daily_bottom_navigation_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatDTO? chat;
  Timer? _timer;
  bool _isSearching = false;
  bool _isLoading = true;

  String _decodeUtf8(String text) {
    return utf8.decode(text.codeUnits);
  }

  Future<void> fetchChat() async {
    Account? account = Provider.of<AccountProvider>(context, listen: false).account;

    int id = account?.id ?? 0;
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/v1/chat/patient?patientId=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setState(() {
      if (response.statusCode == 200) {
        chat = ChatDTO.fromJson(jsonDecode(response.body));
      } else {
        chat = null;
      }
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchChat();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (!_isSearching) {
        fetchChat();
      }
    });
  }

  String _shortenMessage(String message) {
    if (message.length > 30) {
      return "${message.substring(0, 30)}...";
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      bottomNavigationBar: const DailyBottomNavigationBar(),
      drawer: const DailyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: DailyAppBar(title: "Chat"),
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : chat == null
                ? Column(
              children: [
                const Gap(100),
                Image.asset('assets/emoji_not_found.png'),
                const Gap(10),
                const Text(
                  'Nenhuma conversa encontrada',
                  style: TextStyle(fontSize: 16, fontFamily: 'Pangram'),
                  textAlign: TextAlign.center,
                ),
              ],
            )
                : GestureDetector(
              onTap: () {
                if (chat != null && chat!.psychologist != null) {
                  Modular.to.pushNamed(
                    "/chat/messages?patientName=${chat!.psychologist!.name}",
                    arguments: chat!.id,
                  );
                }
              },
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromRGBO(158, 181, 103, 1),
                        ),
                        child: chat?.psychologist?.profilePhoto != null
                            ? ClipOval(
                          child: Image.memory(
                            chat!.psychologist!.profilePhoto!,
                            fit: BoxFit.cover,
                          ),
                        )
                            : const Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      const Gap(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chat?.psychologist?.name ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          if (chat?.lastMessage != null)
                            Text(_shortenMessage(
                                _decodeUtf8(chat!.lastMessage!))),
                        ],
                      ),
                      const Spacer(),
                      if (chat?.lastMessageTime != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: Text(
                            _decodeUtf8(chat!.lastMessageTime!),
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
