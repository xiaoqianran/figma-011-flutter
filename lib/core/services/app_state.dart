import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Icons;

import 'package:figma_011/features/chat/models/chat_conversation.dart';
import 'package:figma_011/features/chat/models/chat_message.dart';
import 'package:figma_011/features/notification/models/notification_item.dart';
import 'package:figma_011/features/payment/models/payment_method.dart';

/// Global app state: auth, profile, settings, chat, notifications.
class AppState extends ChangeNotifier {
  AppState._();

  static final AppState instance = AppState._();

  bool onboardingCompleted = false;
  bool isLoggedIn = false;

  String userName = 'Ferdous Sarker';
  String userEmail = 'ferdous@gmail.com';
  String userPhone = '+880-51248 984';
  String userAddress = 'Block-B, Road-2, Cumilla';
  int sentCount = 3;
  int receivedCount = 9;

  bool rememberMe = false;
  bool pushNotification = true;
  bool emailNotification = false;
  bool locationServices = true;
  bool biometricEnabled = true;
  String language = 'English';

  List<PaymentMethod> paymentMethods =
      List<PaymentMethod>.from(mockPaymentMethods);
  String selectedPaymentMethodId = mockPaymentMethods.first.id;

  final List<ChatConversation> _conversations =
      List<ChatConversation>.from(mockChatConversations);

  List<AppNotification> notifications =
      List<AppNotification>.from(mockNotifications);

  List<ChatConversation> get conversations =>
      List<ChatConversation>.unmodifiable(_conversations);

  String get firstName {
    final parts = userName.trim().split(' ');
    return parts.isEmpty ? userName : parts.first;
  }

  void completeOnboarding() {
    onboardingCompleted = true;
    notifyListeners();
  }

  bool login({required String email, required String password}) {
    if (email.trim().isEmpty || password.length < 6) {
      return false;
    }
    isLoggedIn = true;
    userEmail = email.trim();
    notifyListeners();
    return true;
  }

  bool signUp({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) {
    if (name.trim().isEmpty || email.trim().isEmpty || password.length < 6) {
      return false;
    }
    isLoggedIn = true;
    userName = name.trim();
    userEmail = email.trim();
    if (phone != null && phone.trim().isNotEmpty) {
      userPhone = phone.trim();
    }
    notifyListeners();
    return true;
  }

  void logout() {
    isLoggedIn = false;
    notifyListeners();
  }

  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) {
    userName = name.trim();
    userEmail = email.trim();
    userPhone = phone.trim();
    userAddress = address.trim();
    notifyListeners();
  }

  void updateSecurity({required bool biometric}) {
    biometricEnabled = biometric;
    notifyListeners();
  }

  void updateSettings({
    required bool push,
    required bool email,
    required bool location,
    String? newLanguage,
  }) {
    pushNotification = push;
    emailNotification = email;
    locationServices = location;
    if (newLanguage != null) {
      language = newLanguage;
    }
    notifyListeners();
  }

  void addPaymentMethod(String lastFour) {
    final id = 'card-$lastFour';
    paymentMethods = [
      ...paymentMethods,
      PaymentMethod(
        id: id,
        label: '....$lastFour',
        icon: Icons.credit_card,
      ),
    ];
    selectedPaymentMethodId = id;
    notifyListeners();
  }

  void selectPaymentMethod(String id) {
    selectedPaymentMethodId = id;
    notifyListeners();
  }

  ChatConversation? conversationById(String id) {
    for (final c in _conversations) {
      if (c.id == id) {
        return c;
      }
    }
    return null;
  }

  void markConversationRead(String id) {
    final index = _conversations.indexWhere((c) => c.id == id);
    if (index < 0) {
      return;
    }
    final c = _conversations[index];
    _conversations[index] = ChatConversation(
      id: c.id,
      name: c.name,
      lastMessage: c.lastMessage,
      timestamp: c.timestamp,
      unreadCount: 0,
      messages: c.messages,
    );
    notifyListeners();
  }

  void sendMessage(String conversationId, String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      return;
    }
    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index < 0) {
      return;
    }
    final c = _conversations[index];
    final messages = [
      ...c.messages,
      ChatMessage(text: trimmed, isFromMe: true),
    ];
    _conversations[index] = ChatConversation(
      id: c.id,
      name: c.name,
      lastMessage: trimmed,
      timestamp: 'Now',
      messages: messages,
    );
    notifyListeners();
  }

  void markAllNotificationsRead() {
    notifications = notifications
        .map(
          (n) => AppNotification(
            message: n.message,
            highlight: n.highlight,
            icon: n.icon,
            section: n.section,
            isRead: true,
          ),
        )
        .toList();
    notifyListeners();
  }

  void markNotificationRead(int index) {
    if (index < 0 || index >= notifications.length) {
      return;
    }
    final n = notifications[index];
    if (n.isRead) {
      return;
    }
    final updated = List<AppNotification>.from(notifications);
    updated[index] = AppNotification(
      message: n.message,
      highlight: n.highlight,
      icon: n.icon,
      section: n.section,
      isRead: true,
    );
    notifications = updated;
    notifyListeners();
  }

  void incrementSentCount() {
    sentCount += 1;
    notifyListeners();
  }

  /// Resets state for widget tests.
  @visibleForTesting
  void resetForTest() {
    onboardingCompleted = false;
    isLoggedIn = false;
    notifyListeners();
  }
}