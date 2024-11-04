import 'package:daily/app/modules/chat/pages/chat_details_message.dart';
import 'package:daily/app/modules/chat/pages/chat_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatModule extends Module {

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => ChatPage());
    r.child('/messages', child: (context) => ChatDetailsMessage(chatId: r.args.data, patientName: r.args.queryParams['patientName']));
  }

}