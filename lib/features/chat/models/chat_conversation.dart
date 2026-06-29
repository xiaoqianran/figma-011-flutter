import 'package:figma_011/features/chat/models/chat_message.dart';

/// A chat thread shown in the Messages list — Figma 516:6460.
class ChatConversation {
  const ChatConversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    required this.messages,
  });

  final String id;
  final String name;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final List<ChatMessage> messages;
}

/// Mock conversations from Figma copy.
const List<ChatConversation> mockChatConversations = [
  ChatConversation(
    id: 'sowkot',
    name: 'Sowkot Hasan',
    lastMessage: 'Your package will arrive soon...',
    timestamp: '10:30',
    unreadCount: 2,
    messages: [
      ChatMessage(
        text: 'I will pickup your package\nwithin 1 hours',
        isFromMe: false,
      ),
      ChatMessage(
        text: 'It\'s hard to be productive, man 🙄',
        isFromMe: true,
      ),
      ChatMessage(
        text: 'Okay i\'am wating for you',
        isFromMe: true,
        isFirstInGroup: false,
      ),
    ],
  ),
  ChatConversation(
    id: 'aminur',
    name: 'Aminur Islam',
    lastMessage: 'Thank you sir!',
    timestamp: 'Yeasterday',
    messages: [],
  ),
  ChatConversation(
    id: 'yeasin',
    name: 'Yeasin',
    lastMessage: 'Yes, sure',
    timestamp: '10 Sep',
    messages: [],
  ),
  ChatConversation(
    id: 'russel',
    name: 'Russel',
    lastMessage: 'Welcome!',
    timestamp: '22 Aug',
    messages: [],
  ),
];

ChatConversation? conversationById(String id) {
  for (final conversation in mockChatConversations) {
    if (conversation.id == id) {
      return conversation;
    }
  }
  return null;
}