import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/chat_conversation.dart';
import '../models/chat_message.dart';
import 'chat_detail_screen.dart';
import 'package:intl/intl.dart';

class CommunicationScreen extends StatefulWidget {
  final Student student;
  final List<ChatConversation> conversations;

  const CommunicationScreen({
    Key? key,
    required this.student,
    required this.conversations,
  }) : super(key: key);

  @override
  _CommunicationScreenState createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  ConversationType? _filterType;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filtragem de conversas
    final filteredConversations = widget.conversations.where((conversation) {
      // Filtrar por tipo se aplicável
      if (_filterType != null && conversation.type != _filterType) {
        return false;
      }
      
      // Filtrar por texto de pesquisa
      if (_searchQuery.isEmpty) {
        return true;
      }
      
      return conversation.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             (conversation.lastMessagePreview?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
    }).toList();
    
    // Ordenar conversas: primeiro as não lidas, depois por data mais recente
    filteredConversations.sort((a, b) {
      if (a.hasUnreadMessages && !b.hasUnreadMessages) {
        return -1;
      } else if (!a.hasUnreadMessages && b.hasUnreadMessages) {
        return 1;
      } else {
        return b.lastMessageTime.compareTo(a.lastMessageTime);
      }
    });
    
    // Contar mensagens não lidas
    final int unreadCount = widget.conversations
        .where((conversation) => conversation.hasUnreadMessages)
        .length;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF003366),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo/ChatGPT Image 16 de mai. de 2025, 12_10_18.png',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 8),
            const Text(
              'Comunicação',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundImage: widget.student.profileImagePath != null
              ? AssetImage(widget.student.profileImagePath!)
              : NetworkImage(
                  'https://placehold.co/100x100?text=${widget.student.name[0]}',
                ) as ImageProvider,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Minhas Mensagens',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
                if (unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$unreadCount não lida${unreadCount > 1 ? 's' : ''}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Converse com professores e colegas',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Barra de pesquisa
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Buscar conversas',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchQuery = "";
                        });
                      },
                    )
                  : null,
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Categorias de filtro
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                _buildFilterChip(
                  label: 'Todos',
                  isSelected: _filterType == null,
                  onSelected: (selected) {
                    setState(() {
                      _filterType = null;
                    });
                  },
                ),
                _buildFilterChip(
                  label: 'Individual',
                  isSelected: _filterType == ConversationType.individual,
                  onSelected: (selected) {
                    setState(() {
                      _filterType = selected ? ConversationType.individual : null;
                    });
                  },
                ),
                _buildFilterChip(
                  label: 'Grupos',
                  isSelected: _filterType == ConversationType.group,
                  onSelected: (selected) {
                    setState(() {
                      _filterType = selected ? ConversationType.group : null;
                    });
                  },
                ),
                _buildFilterChip(
                  label: 'Oficial',
                  isSelected: _filterType == ConversationType.official,
                  onSelected: (selected) {
                    setState(() {
                      _filterType = selected ? ConversationType.official : null;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          
          // Lista de conversas
          Expanded(
            child: filteredConversations.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _searchQuery.isNotEmpty
                          ? 'Nenhuma conversa encontrada'
                          : 'Nenhuma conversa disponível',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (_searchQuery.isNotEmpty)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = "";
                              _filterType = null;
                            });
                          },
                          child: const Text('Limpar filtros'),
                        ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: filteredConversations.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final conversation = filteredConversations[index];
                    return _buildConversationItem(conversation);
                  },
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nova conversa'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        backgroundColor: const Color(0xFF003366),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
  
  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required Function(bool) onSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: onSelected,
        selectedColor: const Color(0xFF003366).withOpacity(0.2),
        labelStyle: TextStyle(
          color: isSelected ? const Color(0xFF003366) : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        checkmarkColor: const Color(0xFF003366),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
  
  Widget _buildConversationItem(ChatConversation conversation) {
    // Formatadores de data
    final dateFormat = DateFormat('dd/MM/yy');
    final timeFormat = DateFormat('HH:mm');
    
    // Formatar timestamp da última mensagem
    String formattedTime;
    final now = DateTime.now();
    final lastMessageTime = conversation.lastMessageTime;
    
    if (lastMessageTime.year == now.year && 
        lastMessageTime.month == now.month && 
        lastMessageTime.day == now.day) {
      // Se for hoje, mostra apenas a hora
      formattedTime = timeFormat.format(lastMessageTime);
    } else {
      // Caso contrário, mostra a data
      formattedTime = dateFormat.format(lastMessageTime);
    }
    
    // Determinar o ícone baseado no tipo de conversa
    IconData typeIcon;
    Color typeColor;
    
    switch (conversation.type) {
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
        break;
      case ConversationType.channel:
        typeIcon = Icons.campaign;
        typeColor = Colors.purple;
        break;
    }
    
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(
              conversation: conversation,
              currentUserId: 'student1', // ID do estudante atual
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: conversation.hasUnreadMessages 
              ? const Color(0xFF003366).withOpacity(0.05)
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      typeIcon,
                      color: typeColor,
                      size: 24,
                    ),
                  ),
                ),
                if (conversation.hasUnreadMessages)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.title,
                          style: TextStyle(
                            fontWeight: conversation.hasUnreadMessages ? FontWeight.bold : FontWeight.normal,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        formattedTime,
                        style: TextStyle(
                          color: conversation.hasUnreadMessages ? const Color(0xFF003366) : Colors.grey,
                          fontSize: 12,
                          fontWeight: conversation.hasUnreadMessages ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    conversation.lastMessagePreview ?? '',
                    style: TextStyle(
                      color: conversation.hasUnreadMessages ? Colors.black87 : Colors.grey[700],
                      fontWeight: conversation.hasUnreadMessages ? FontWeight.w500 : FontWeight.normal,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}