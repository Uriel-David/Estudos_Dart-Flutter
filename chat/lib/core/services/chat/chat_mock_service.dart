import 'dart:async';
import 'dart:math';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/models/chat_messages.dart';
import 'package:chat/core/services/chat/chat_services.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Hello World',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Computer',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Hello Computer',
      createdAt: DateTime.now(),
      userId: '321',
      userName: 'Person',
      userImageURL: 'assets/images/avatar.png',
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller?.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageURL,
    );

    _msgs.add(newMessage);
    _controller?.add(_msgs);

    return newMessage;
  }
}
