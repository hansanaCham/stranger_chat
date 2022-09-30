import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stranger_chat/widgets/auth/drop_down_menu.dart';

import '../widgets/chats/chates.dart';

class ChatLog extends StatefulWidget {
  const ChatLog({super.key});

  @override
  State<ChatLog> createState() => _ChatLogState();
}

class _ChatLogState extends State<ChatLog> {
  // find a stranger
  void _findStranger() async {
    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('user_id', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    final rnd = Random();
    var r = rnd.nextInt(users.docs.length - 0);
    // create a chate
    final ownerUserName = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final ref = await FirebaseFirestore.instance.collection('chats').add(
      {
        'created_at': Timestamp.now(),
        'last_modified': Timestamp.now(),
        'owner': FirebaseAuth.instance.currentUser!.uid,
        'owner_name': ownerUserName['userName'],
        'stranger': users.docs[r].id,
        'stranger_name': users.docs[r]['userName'],
        'participants': [
          FirebaseAuth.instance.currentUser!.uid,
          users.docs[r].id,
        ]
      },
    );
    FirebaseFirestore.instance.collection("chats/${ref.id}/messages").add(
      {
        'created_at': Timestamp.now(),
        'user_id': FirebaseAuth.instance.currentUser!.uid,
        'text': 'Hi Stranger',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stranger Chat'),
        actions: const [DropDownMenu()],
      ),
      body: Column(
        children: const [
          Expanded(
            child: Chates(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _findStranger,
        child: const Icon(Icons.question_answer_sharp),
      ),
    );
  }
}
