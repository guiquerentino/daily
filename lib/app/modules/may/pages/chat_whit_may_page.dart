import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../emotions/pages/home_page.dart';
import '../../ui/daily_text.dart';

class ChatWithMayPage extends StatefulWidget {
  const ChatWithMayPage({super.key});

  @override
  State<ChatWithMayPage> createState() => _ChatWithMayPageState();
}

class _ChatWithMayPageState extends State<ChatWithMayPage> {
  TextEditingController? _textController;
  ScrollController _scrollController = ScrollController();
  List<Widget> _messages = [];
  List<String> _textMessages = [];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _messages.add(_buildMessageBubble("Olá, eu sou a May! Como posso te auxiliar hoje?", true));
        _textMessages.add("Olá, eu sou a May! Como posso te auxiliar hoje?");
        _scrollToBottom();
      });
    });
  }

  @override
  void dispose() {
    _textController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _textController?.text.trim();
    if (text != null && text.isNotEmpty) {
      setState(() {
        _messages.add(_buildMessageBubble(text, false));
        _textMessages.add(text);
        _scrollToBottom();

        final gemini = Gemini.instance;

        String geminiConfig = 'Você é uma inteligência artificial chamada May (em hipotese alguma você deve falar que seu nome não é May), e esta em um app chamado Daily, o app é focado na saúde mental, o usuário consegue adicionar registros de suas emoções (bravo,feliz,muito feliz,triste etc) e colocar motivos (faculdade,finanças,conjuge etc), além disso ele consegue fazer meditação, anotações, adicionar lembretes e falar com seu psicólogo. Você deve responder as perguntas deles focada na área da Saúde Mental, caso a pergunta saia muito do contexto de saúde mental, você não deve responder. Tente recomendar a utilização de serviços do Aplicativo. As mensagens ja enviadas foram essas (a primeira mensagem foi enviada por você automaticamente):' + _textMessages.toString() + "A mensagem enviada pelo usuário é a seguinte, responda ela: " + text;

        gemini.text(geminiConfig).then((value) {
          setState(() {
            _messages.add(_buildMessageBubble(value!.output!.replaceAll('*', ''), true));
            _textMessages.add(value!.output!.replaceAll('*', ''));
            _scrollToBottom();
          });

          _textController?.clear();
        });
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _clearMessages() {
    setState(() {
      _messages.clear();
      _messages.add(_buildMessageBubble("Olá, eu sou a May! Como posso te auxiliar hoje?", true));
      _textMessages.add("Olá, eu sou a May! Como posso te auxiliar hoje?");
      _scrollToBottom();
    });
  }

  Widget _buildMessageBubble(String message, bool isSentByMe) {
    return Align(
      alignment: isSentByMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        width: 300,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.grey[300] : const Color.fromRGBO(158, 181, 103, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(color: isSentByMe ? Colors.black : Colors.white, fontFamily: 'Pangram', fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    Modular.to.navigate('/emotions${HomePage.ROUTE_NAME}');
                  },
                ),
                DailyText.text("Chat com a May").header.medium.bold,
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, size: 30),
                  onSelected: (value) {
                    if (value == 'clear') {
                      _clearMessages();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'clear',
                        child: Text('Limpar conversa'),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: _messages,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 30, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .77,
                  height: 50,
                  child: TextFormField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Digite uma mensagem...',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Color.fromRGBO(196, 196, 196, 0.20),
                    ),
                    onFieldSubmitted: (value) => _sendMessage(),
                  ),
                ),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(126, 145, 82, 1),
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
