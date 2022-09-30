import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stranger_chat/screens/chat_screen.dart';

class Chates extends StatelessWidget {
  const Chates({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats').where(
                'participants',
                arrayContainsAny: [FirebaseAuth.instance.currentUser!.uid])
            // .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final _chatDocs = snapshot.data?.docs;
          // print(_chatDocs!.length);
          return Container(
            color: Colors.white70,
            child: ListView.builder(
              padding: const EdgeInsets.all(3),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://firebasestorage.googleapis.com/v0/b/stranger-chat-8954d.appspot.com/o/user_images%2FcD3nbT74jcOSam8jTICvFA1JCnp2.jpg?alt=media&token=ef1bb7dd-dc81-4500-a8d6-3aa66a7e2cb6'),
                          ),
                          title: Text(
                            _chatDocs[index]['owner'] ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? _chatDocs[index]['stranger_name']
                                : _chatDocs[index]['owner_name'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    _chatDocs[index].id,
                                    _chatDocs[index]['stranger_name']),
                              ),
                            );
                          },
                          dense: true,
                          tileColor: Colors.black26,
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: _chatDocs!.length,
            ),
          );
        });
  }
}
