// Enum para definir os status da mensagem
enum MessageStatus {
  sending,   // Mensagem está sendo enviada
  sent,      // Mensagem foi enviada para o servidor
  delivered, // Mensagem foi entregue ao destinatário
  read,      // Mensagem foi lida pelo destinatário
  failed     // Falha ao enviar a mensagem
}

// Enum para definir os tipos de mensagem
enum MessageType {
  text,      // Mensagem de texto simples
  image,     // Imagem
  video,     // Vídeo
  file,      // Arquivo anexado
  audio,     // Mensagem de áudio
  system,    // Mensagem do sistema (aviso, notificação, etc.)
  notification // Mensagem de notificação
}

class ChatMessage {
  final String id;
  final String senderId;
  final String? senderName;
  final String? senderAvatar;
  final String content;
  final DateTime timestamp;
  final MessageStatus status;
  final bool isRead;
  final bool isSentByMe;
  final MessageType type;
  final String? attachmentUrl;
  final String? thumbnailUrl;

  ChatMessage({
    required this.id,
    required this.senderId,
    this.senderName,
    this.senderAvatar,
    required this.content,
    required this.timestamp,
    required this.status,
    this.isRead = false,
    required this.isSentByMe,
    this.type = MessageType.text,
    this.attachmentUrl,
    this.thumbnailUrl,
  });

  // Retorna uma cópia da mensagem com os valores atualizados
  ChatMessage copyWith({
    String? id,
    String? senderId,
    String? senderName,
    String? senderAvatar,
    String? content,
    DateTime? timestamp,
    MessageStatus? status,
    bool? isRead,
    bool? isSentByMe,
    MessageType? type,
    String? attachmentUrl,
    String? thumbnailUrl,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      isRead: isRead ?? this.isRead,
      isSentByMe: isSentByMe ?? this.isSentByMe,
      type: type ?? this.type,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  // Verifica se a mensagem tem um anexo
  bool get hasAttachment {
    return type != MessageType.text && attachmentUrl != null;
  }

  // Formata o horário da mensagem para exibição
  String getFormattedTime() {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  // Formata a data completa da mensagem para exibição
  String getFormattedDate() {
    return '${timestamp.day.toString().padLeft(2, '0')}/${timestamp.month.toString().padLeft(2, '0')}/${timestamp.year}';
  }
}