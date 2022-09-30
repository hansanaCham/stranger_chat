import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stranger_chat/widgets/chats/messageBubble.dart';

class Messages extends StatelessWidget {
  final String _chatId;
  const Messages(this._chatId, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .doc(_chatId)
            .collection('messages')
            .orderBy(
              'created_at',
              descending: true,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = snapshot.data?.docs;
          print(chatDocs!.length);
          return ListView.builder(
            reverse: true,
            itemBuilder: (context, index) {
              return MessageBubble(
                chatDocs[index]['text'],
                chatDocs[index]['user_id'] ==
                    FirebaseAuth.instance.currentUser!.uid,
                key: ValueKey(chatDocs[index].id),
              );
            },
            itemCount: chatDocs.length,
          );
        });
  }
}
