import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String _message;
  final bool _isMe;
  final Key key;
  const MessageBubble(this._message, this._isMe, {required this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: _isMe ? Colors.blueGrey : Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft:
                  !_isMe ? const Radius.circular(0) : const Radius.circular(12),
              bottomRight:
                  _isMe ? const Radius.circular(0) : const Radius.circular(12),
            ),
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            _message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
