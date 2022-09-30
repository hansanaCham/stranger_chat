import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String _chatId;
  const NewMessage(this._chatId, {super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enterMessage = '';
  final _controller = TextEditingController();
  void _sendMessage() {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._chatId)
        .collection('messages')
        .add({
      'text': _enterMessage,
      'created_at': Timestamp.now(),
      'user_id': user!.uid,
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enterMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: _enterMessage.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
