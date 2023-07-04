import 'package:flutter/material.dart';
import 'package:oech_app/core/theme/colors.dart';

import '../../data/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chatContents = [
      Flexible(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 220
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color:
                message.isMine ? AppColors.primaryColor : AppColors.grey1Color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message.content,
            style: TextStyle(
                color: message.isMine ? Colors.white : AppColors.textColor,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    ];

    if (message.isMine) {
      chatContents = chatContents.reversed.toList();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisAlignment:
            message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: chatContents,
      ),
    );
  }
}
