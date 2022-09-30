import 'package:flutter/material.dart';
import 'package:stranger_chat/widgets/chats/NewMessage.dart';
import 'package:stranger_chat/widgets/chats/messages.dart';

import '../widgets/auth/drop_down_menu.dart';

class ChatScreen extends StatelessWidget {
  final String _chatId;
  final String _name;
  const ChatScreen(this._chatId, this._name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
        actions: const [DropDownMenu()],
      ),
      body: Column(
        children: [
          Expanded(child: Messages(_chatId)),
          NewMessage(_chatId),
        ],
      ),
    );
  }
}
