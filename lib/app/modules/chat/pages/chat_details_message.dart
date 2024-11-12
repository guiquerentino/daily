import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../core/domain/chat_message_dto.dart';

class ChatDetailsMessage extends StatefulWidget {
  final int chatId;
  final String? patientName;
  const ChatDetailsMessage({super.key, required this.chatId, required this.patientName});

  @override
  State<ChatDetailsMessage> createState() => _ChatDetailsMessageState();
}

class _ChatDetailsMessageState extends State<ChatDetailsMessage> {
  List<ChatMessageDto> messages = [];
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    int id = widget.chatId;
    print(id);
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/v1/chat?chatId=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        messages = ChatMessageDto.fromJsonList(jsonDecode(response.body));
      });
    } else {
      print('Failed to load messages');
    }
  }

  String _decodeUtf8(String text) {
    return utf8.decode(text.codeUnits);
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yy HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Modular.to.pushNamed('/chat');
          },
          child: Icon(Icons.arrow_back_outlined),
        ),
        title: Text(widget.patientName!),
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isNotEmpty
                ? ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final bool isPsychologist = message.sender == 'psychologist';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Align(
                    alignment: !isPsychologist ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: !isPsychologist ? const Color.fromRGBO(158, 181, 103, 1) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _decodeUtf8(message.content),
                            style: TextStyle(
                              color: !isPsychologist ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(message.sentAt!),
                            style: TextStyle(
                              fontSize: 10,
                              color: !isPsychologist ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
                : Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Digite sua mensagem...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color.fromRGBO(158, 181, 103, 1)),
                  onPressed: () async {
                    ChatMessageDto request = ChatMessageDto(chatId: widget.chatId, sender: 'patient', content: _messageController.text);

                    final response = await http.post(
                        Uri.parse('http://10.0.2.2:8080/api/v1/chat'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(request.toJson())
                    );

                    if(response.statusCode == 200){
                      fetchMessages();
                      _messageController.clear();
                    }

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
