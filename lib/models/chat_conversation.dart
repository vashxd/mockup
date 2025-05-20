import 'chat_message.dart';

// Enum para definir os tipos de conversa
enum ConversationType {
  individual,  // Conversa entre dois usuários
  group,       // Grupo de conversa com múltiplos usuários
  official,    // Comunicados oficiais da escola
  channel,     // Canal de comunicação (geralmente unidirecional)
}

class ChatConversation {
  final String id;
  final String title;
  final List<String> participantIds;
  final List<String> participantNames;
  final List<String?> participantAvatars;
  final ConversationType type;
  final DateTime lastMessageTime;
  final bool hasUnreadMessages;
  final String lastMessagePreview;
  final List<ChatMessage> messages;

  ChatConversation({
    required this.id,
    required this.title,
    required this.participantIds,
    required this.participantNames,
    required this.participantAvatars,
    required this.type,
    required this.lastMessageTime,
    required this.hasUnreadMessages,
    required this.lastMessagePreview,
    required this.messages,
  });

  // Retorna a imagem de avatar para exibição na lista de conversas
  String? getConversationAvatar() {
    // Para conversas individuais, use o avatar do outro participante
    if (type == ConversationType.individual) {
      // Assumindo que o primeiro avatar na lista é do usuário atual
      return participantAvatars.length > 1 ? participantAvatars[1] : null;
    }
    
    // Para grupos ou canais, pode retornar null ou um avatar padrão
    return null;
  }
  
  // Verifica se a conversa é somente para leitura (como canais oficiais)
  bool get isReadOnly {
    return type == ConversationType.official || type == ConversationType.channel;
  }
  
  // Formata a hora da última mensagem para exibição
  String getFormattedLastMessageTime() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(lastMessageTime.year, lastMessageTime.month, lastMessageTime.day);

    if (messageDate == today) {
      return '${lastMessageTime.hour.toString().padLeft(2, '0')}:${lastMessageTime.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == yesterday) {
      return 'Ontem';
    } else {
      return '${lastMessageTime.day}/${lastMessageTime.month}';
    }
  }
  
  // Adiciona uma nova mensagem à conversa
  ChatConversation addMessage(ChatMessage message) {
    final updatedMessages = List<ChatMessage>.from(messages)..add(message);
    
    return ChatConversation(
      id: id,
      title: title,
      participantIds: participantIds,
      participantNames: participantNames,
      participantAvatars: participantAvatars,
      type: type,
      lastMessageTime: message.timestamp,
      hasUnreadMessages: true,
      lastMessagePreview: message.content,
      messages: updatedMessages,
    );
  }
  
  // Marca todas as mensagens como lidas
  ChatConversation markAllAsRead() {
    final readMessages = messages.map((message) => 
      message.isRead ? message : message.copyWith(isRead: true)
    ).toList();
    
    return ChatConversation(
      id: id,
      title: title,
      participantIds: participantIds,
      participantNames: participantNames,
      participantAvatars: participantAvatars,
      type: type,
      lastMessageTime: lastMessageTime,
      hasUnreadMessages: false,
      lastMessagePreview: lastMessagePreview,
      messages: readMessages,
    );
  }
}