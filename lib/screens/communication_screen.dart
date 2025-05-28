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
    
    return Scaffold(      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Header moderno com gradiente
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              'assets/logo/ChatGPT Image 16 de mai. de 2025, 12_10_18.png',
                              width: 28,
                              height: 28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Comunicação',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundImage: widget.student.profileImagePath != null
                              ? AssetImage(widget.student.profileImagePath!)
                              : NetworkImage(
                                  'https://placehold.co/100x100?text=${widget.student.name[0]}',
                                ) as ImageProvider,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Minhas Mensagens',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Converse com professores e colegas',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (unreadCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEF4444),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '$unreadCount não lida${unreadCount > 1 ? 's' : ''}',
                                  style: const TextStyle(
                                    color: Color(0xFF1F2937),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Expanded(
              child: _buildMainContent(filteredConversations),
            ),
          ],
        ),
      ),      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.chat_bubble_outline_rounded, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Nova conversa'),
                ],
              ),
              backgroundColor: const Color(0xFF6366F1),
              duration: const Duration(seconds: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.edit_rounded),
        label: const Text(
          'Nova',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildMainContent(List<ChatConversation> filteredConversations) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 1200),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 24),
          // Barra de pesquisa moderna
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Buscar conversas...',
                hintStyle: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: Container(
                  padding: const EdgeInsets.all(12),
                  child: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF6B7280),
                    size: 20,
                  ),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Color(0xFF6B7280),
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = "";
                          });
                        },
                      ),
                    )
                  : null,
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Filtros modernos
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildModernFilterChip(
                  label: 'Todos',
                  icon: Icons.forum_rounded,
                  isSelected: _filterType == null,
                  onSelected: (selected) {
                    setState(() {
                      _filterType = null;
                    });
                  },
                ),
                const SizedBox(width: 12),
                _buildModernFilterChip(
                  label: 'Individual',
                  icon: Icons.person_rounded,
                  isSelected: _filterType == ConversationType.individual,
                  onSelected: (selected) {
                    setState(() {
                      _filterType = selected ? ConversationType.individual : null;
                    });
                  },
                ),
                const SizedBox(width: 12),
                _buildModernFilterChip(
                  label: 'Grupos',
                  icon: Icons.group_rounded,
                  isSelected: _filterType == ConversationType.group,
                  onSelected: (selected) {
                    setState(() {
                      _filterType = selected ? ConversationType.group : null;
                    });
                  },
                ),
                const SizedBox(width: 12),
                _buildModernFilterChip(
                  label: 'Oficial',
                  icon: Icons.school_rounded,
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
          const SizedBox(height: 24),
          
          // Lista de conversas
          Expanded(
            child: filteredConversations.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredConversations.length,
                  itemBuilder: (context, index) {
                    final conversation = filteredConversations[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildModernConversationItem(conversation),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.chat_bubble_outline_rounded,
              size: 64,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            _searchQuery.isNotEmpty
              ? 'Nenhuma conversa encontrada'
              : 'Nenhuma conversa disponível',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
              ? 'Tente buscar por outros termos'
              : 'Suas conversas aparecerão aqui',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
            ),
          ),
          if (_searchQuery.isNotEmpty) ...[
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                    _searchQuery = "";
                    _filterType = null;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(
                  Icons.clear_all_rounded,
                  color: Colors.white,
                ),
                label: const Text(
                  'Limpar filtros',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildModernFilterChip({
    required String label,
    required IconData icon,
    required bool isSelected,
    required Function(bool) onSelected,
  }) {
    return GestureDetector(
      onTap: () => onSelected(!isSelected),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              )
            : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFFE5E7EB),
            width: 1.5,
          ),
          boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 1),
                ),
              ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : const Color(0xFF6B7280),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF1F2937),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernConversationItem(ChatConversation conversation) {    // Formatadores de data
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
    
    // Determinar o ícone e cor baseado no tipo de conversa
    IconData typeIcon;
    List<Color> typeGradient;
    
    switch (conversation.type) {
      case ConversationType.individual:
        typeIcon = Icons.person_rounded;
        typeGradient = [const Color(0xFF3B82F6), const Color(0xFF1E40AF)];
        break;
      case ConversationType.group:
        typeIcon = Icons.group_rounded;
        typeGradient = [const Color(0xFF10B981), const Color(0xFF059669)];
        break;
      case ConversationType.official:
        typeIcon = Icons.school_rounded;
        typeGradient = [const Color(0xFFEF4444), const Color(0xFFDC2626)];
        break;
      case ConversationType.channel:
        typeIcon = Icons.campaign_rounded;
        typeGradient = [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)];
        break;
    }
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: conversation.hasUnreadMessages
          ? Border.all(color: const Color(0xFF6366F1).withOpacity(0.3), width: 2)
          : Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: conversation.hasUnreadMessages
              ? const Color(0xFF6366F1).withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
            blurRadius: conversation.hasUnreadMessages ? 12 : 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
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
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Avatar com ícone de tipo
                Stack(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: typeGradient,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: typeGradient[0].withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        typeIcon,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    if (conversation.hasUnreadMessages)
                      Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFEF4444).withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                
                // Conteúdo da conversa
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
                                fontWeight: conversation.hasUnreadMessages ? FontWeight.w700 : FontWeight.w600,
                                fontSize: 16,
                                color: const Color(0xFF1F2937),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: conversation.hasUnreadMessages 
                                ? const Color(0xFF6366F1).withOpacity(0.1)
                                : const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              formattedTime,
                              style: TextStyle(
                                color: conversation.hasUnreadMessages 
                                  ? const Color(0xFF6366F1) 
                                  : const Color(0xFF6B7280),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        conversation.lastMessagePreview ?? 'Sem mensagens ainda',
                        style: TextStyle(
                          color: conversation.hasUnreadMessages 
                            ? const Color(0xFF374151)
                            : const Color(0xFF6B7280),
                          fontWeight: conversation.hasUnreadMessages ? FontWeight.w500 : FontWeight.w400,
                          fontSize: 14,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                // Indicador de conversa
                const SizedBox(width: 12),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: conversation.hasUnreadMessages 
                    ? const Color(0xFF6366F1)
                    : const Color(0xFF9CA3AF),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}