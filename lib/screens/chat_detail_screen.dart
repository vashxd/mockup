import 'package:flutter/material.dart';
import '../models/chat_conversation.dart';
import '../models/chat_message.dart';
import 'package:intl/intl.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatConversation conversation;
  final String currentUserId;

  const ChatDetailScreen({
    Key? key,
    required this.conversation,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messages = List.from(widget.conversation.messages);
    
    // Rolar para baixo quando a tela carregar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = ChatMessage(
      id: 'msg_new_${DateTime.now().millisecondsSinceEpoch}',
      senderId: widget.currentUserId,
      senderName: 'Sâmilly Cavalcante',
      content: _messageController.text.trim(),
      timestamp: DateTime.now(),
      type: MessageType.text,
      isSentByMe: true,
      status: MessageStatus.sent,
      isRead: false,
    );

    setState(() {
      _messages.add(newMessage);
      _messageController.clear();
      _isTyping = false;
    });

    // Rolar para baixo para mostrar a nova mensagem
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Agrupar mensagens por dia
    final Map<String, List<ChatMessage>> messagesByDate = {};
    
    for (var message in _messages) {
      final String dateKey = DateFormat('dd/MM/yyyy').format(message.timestamp);
      if (!messagesByDate.containsKey(dateKey)) {
        messagesByDate[dateKey] = [];
      }
      messagesByDate[dateKey]!.add(message);
    }
    
    // Ordenar as datas
    final sortedDates = messagesByDate.keys.toList()..sort();
    
    // Determinar informações com base no tipo de conversa
    IconData typeIcon;
    Color typeColor;
    bool canReply = true; // Por padrão pode responder
    
    switch (widget.conversation.type) {
      case ConversationType.individual:
        typeIcon = Icons.person;
        typeColor = Colors.blue;
        break;
      case ConversationType.group:
        typeIcon = Icons.group;
        typeColor = Colors.green;
        break;
      case ConversationType.official:
        typeIcon = Icons.school;
        typeColor = Colors.red;
        canReply = false; // Não pode responder a mensagens oficiais
        break;
      case ConversationType.channel:
        typeIcon = Icons.campaign;
        typeColor = Colors.purple;
        canReply = false;
        break;
    }
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF003366),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: typeColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  typeIcon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.conversation.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.conversation.type == ConversationType.individual)
                    Text(
                      'Online', // Status fictício
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[200],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Mostrar opções da conversa
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opções da conversa'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Mensagens
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: sortedDates.length,
              itemBuilder: (context, dateIndex) {
                final date = sortedDates[dateIndex];
                final messagesOnDate = messagesByDate[date]!;
                
                return Column(
                  children: [
                    // Data
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _formatDateHeader(date),
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // Mensagens deste dia
                    ...messagesOnDate.map((message) {
                      final isMyMessage = message.senderId == widget.currentUserId;
                      final messageTime = DateFormat('HH:mm').format(message.timestamp);
                      
                      // Determinar a cor da bolha de mensagem com base no tipo e remetente
                      Color bubbleColor;
                      Color textColor;
                      
                      if (isMyMessage) {
                        bubbleColor = const Color(0xFF003366);
                        textColor = Colors.white;
                      } else {
                        if (message.type == MessageType.notification) {
                          bubbleColor = Colors.amber.shade100;
                          textColor = Colors.black87;
                        } else {
                          bubbleColor = Colors.white;
                          textColor = Colors.black;
                        }
                      }
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: isMyMessage 
                              ? MainAxisAlignment.end 
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Avatar para mensagens de outros
                            if (!isMyMessage && message.type != MessageType.notification)                              CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.grey[300] ?? Colors.grey,                                child: Text(
                                  (message.senderName ?? 'U')[0],
                                  style: TextStyle(
                                    color: Colors.grey[700] ?? Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              
                            if (!isMyMessage && message.type != MessageType.notification)
                              const SizedBox(width: 8),
                              
                            // Mensagem
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.75,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: bubbleColor,
                                  borderRadius: BorderRadius.circular(16).copyWith(
                                    bottomLeft: isMyMessage ? const Radius.circular(16) : const Radius.circular(4),
                                    bottomRight: isMyMessage ? const Radius.circular(4) : const Radius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Nome do remetente (para mensagens não enviadas por mim)
                                    if (!isMyMessage && message.type != MessageType.notification)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 4.0),                                        child: Text(
                                          message.senderName ?? 'Usuário',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: textColor.withOpacity(0.8),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    
                                    // Corpo da mensagem
                                    Text(
                                      message.content,
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                    
                                    // Horário da mensagem
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            messageTime,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: textColor.withOpacity(0.6),
                                            ),
                                          ),
                                          
                                          // Status de leitura (apenas para minhas mensagens)
                                          if (isMyMessage)
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4),
                                              child: Icon(
                                                message.isRead ? Icons.done_all : Icons.done,
                                                size: 14,
                                                color: message.isRead 
                                                    ? Colors.blue[200]
                                                    : textColor.withOpacity(0.6),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                );
              },
            ),
          ),
          
          // Indicador de digitação
          if (_isTyping)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                'Digitando...',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                ),
              ),
            ),
          
          // Campo de texto e botão de envio
          if (canReply)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.attach_file, color: Color(0xFF003366)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Anexar arquivo'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        onChanged: (text) {
                          setState(() {
                            _isTyping = text.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Digite uma mensagem...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        maxLines: null,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Color(0xFF003366)),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Você não pode responder a esta conversa',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  String _formatDateHeader(String dateStr) {
    final DateTime date = DateFormat('dd/MM/yyyy').parse(dateStr);
    final DateTime now = DateTime.now();
    final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Hoje';
    } else if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
      return 'Ontem';
    } else {
      return dateStr;
    }
  }
}