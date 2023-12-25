import 'package:chat/components/message_bubble.dart';
import 'package:chat/core/models/chat_messages.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    return StreamBuilder<List<ChatMessage>>(
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Data. Go talk?'));
        }

        final msgs = snapshot.data!;
        return ListView.builder(
          reverse: true,
          itemCount: msgs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            key: ValueKey(msgs[index].id),
            message: msgs[index],
            belongsToCurrentUser: currentUser?.id == msgs[index].userId,
          ),
        );
      },
      stream: ChatService().messagesStream(),
    );
  }
}
