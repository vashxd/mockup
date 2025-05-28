import 'package:flutter/material.dart';
import '../models/student.dart';
import '../utils/platform_helper.dart';

class HomeScreen extends StatelessWidget {
  final Student student;

  const HomeScreen({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Detectar se estamos na web e se a tela é grande
    final isLargeScreen = MediaQuery.of(context).size.width > 800;
    final isWebOrTablet = MediaQuery.of(context).size.width > 600;
      return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'assets/logo/ChatGPT Image 16 de mai. de 2025, 12_10_18.png',
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 12),
            if (isWebOrTablet)
              const Text("Portal do Aluno"),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: PopupMenuButton<String>(
              offset: const Offset(0, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  backgroundImage: student.profileImagePath != null
                    ? AssetImage(student.profileImagePath!)
                    : NetworkImage(
                        'https://placehold.co/100x100?text=${student.name[0]}',
                      ) as ImageProvider,
                ),
              ),
              onSelected: (value) {
                if (value == 'profile') {
                  Navigator.pushNamed(context, '/profile', arguments: student);
                } else if (value == 'logout') {
                  Navigator.pushNamedAndRemoveUntil(
                    context, 
                    '/login', 
                    (route) => false
                  );
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person_outline, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 12),
                      const Text('Perfil'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red.shade400),
                      const SizedBox(width: 12),
                      Text('Sair', style: TextStyle(color: Colors.red.shade400)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isLargeScreen ? 1200 : double.infinity,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: isWebOrTablet ? 24 : 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              
              // Header com saudação
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Olá, ${student.name.split(' ')[0]}! 👋",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),                          Text(
                            "Bem-vindo ao Portal do Aluno",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.white,
                        backgroundImage: student.profileImagePath != null
                          ? AssetImage(student.profileImagePath!)
                          : NetworkImage(
                              'https://placehold.co/200x200?text=${student.name[0]}',
                            ) as ImageProvider,
                      ),
                    ),
                  ],
                ),
              ),
                
              const SizedBox(height: 32),
              
              // Seção "MEU DIA"
              Text(
                'Meu Dia',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Acesse rapidamente suas atividades do dia',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 20),
              
              // Cards de serviço "MEU DIA" - Layout responsivo
              isLargeScreen 
                ? _buildLargeScreenDailyServices(context)
                : _buildMobileScreenDailyServices(context),

              const SizedBox(height: 40),
              
              // Seção "OUTROS SERVIÇOS"
              Text(
                'Outros Serviços',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Explore todos os recursos disponíveis',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6B7280),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Cards de outros serviços - Layout responsivo
              isLargeScreen 
                ? _buildLargeScreenServices(context)
                : _buildMobileScreenServices(context),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLargeScreenDailyServices(BuildContext context) {
    // Layout para telas grandes (web)
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: _buildServiceItem(
            context,
            icon: Icons.book,
            label: 'Atividade',
            onTap: () {
              Navigator.pushNamed(context, '/activities');
            },
            isLargeScreen: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildServiceItem(
            context,
            icon: Icons.calendar_today,
            label: 'Calendário',
            onTap: () {
              Navigator.pushNamed(context, '/calendar');
            },
            isLargeScreen: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildServiceItem(
            context,
            icon: Icons.chat_bubble_outline,
            label: 'Comunicação',
            onTap: () {},
            isLargeScreen: true,
          ),
        ),
      ],
    );
  }
  Widget _buildMobileScreenDailyServices(BuildContext context) {
    // Layout para telas menores (mobile)
    return Row(
      children: [
        Expanded(
          child: _buildServiceItem(
            context,
            icon: Icons.book,
            label: 'Atividade',
            onTap: () {
              Navigator.pushNamed(context, '/activities');
            },
            isLargeScreen: false,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildServiceItem(
            context,
            icon: Icons.calendar_today,
            label: 'Calendário',
            onTap: () {
              Navigator.pushNamed(context, '/calendar');
            },
            isLargeScreen: false,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildServiceItem(
            context,
            icon: Icons.chat_bubble_outline,
            label: 'Comunicação',
            onTap: () {},
            isLargeScreen: false,
          ),
        ),
      ],
    );
  }

  Widget _buildLargeScreenServices(BuildContext context) {
    // Layout Grid para telas grandes (web) - 4 cards em uma linha
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildServiceCard(
                context,
                icon: Icons.description,
                label: 'Boletim',
                onTap: () {
                  Navigator.pushNamed(context, '/report_card');
                },
                showArrow: true,
                isLargeScreen: true,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildServiceCard(
                context,
                icon: Icons.notifications_none,
                label: 'Notificações',
                onTap: () {
                  Navigator.pushNamed(context, '/notifications');
                },
                showArrow: true,
                isLargeScreen: true,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildServiceCard(
                context,
                icon: Icons.link,
                label: 'e-Class',
                onTap: () {
                  Navigator.pushNamed(context, '/eclass');
                },
                showExternalIcon: true,
                isLargeScreen: true,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildServiceCard(
                context,
                icon: Icons.insert_drive_file,
                label: 'Documentos',
                onTap: () {
                  Navigator.pushNamed(context, '/documents');
                },
                showArrow: true,
                isLargeScreen: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildMobileScreenServices(BuildContext context) {
    // Layout para telas menores (mobile) - Layout em grid 2x2 com altura fixa
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildServiceCard(
                context,
                icon: Icons.description,
                label: 'Boletim',
                onTap: () {
                  Navigator.pushNamed(context, '/report_card');
                },
                showArrow: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildServiceCard(
                context,
                icon: Icons.notifications_none,
                label: 'Avisos',
                onTap: () {
                  Navigator.pushNamed(context, '/notifications');
                },
                showArrow: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildServiceCard(
                context,
                icon: Icons.link,
                label: 'e-Class',
                onTap: () {
                  Navigator.pushNamed(context, '/eclass');
                },
                showExternalIcon: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildServiceCard(
                context,
                icon: Icons.insert_drive_file,
                label: 'Arquivos',
                onTap: () {
                  Navigator.pushNamed(context, '/documents');
                },
                showArrow: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildServiceItem(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap, bool isLargeScreen = false}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: isLargeScreen ? 140 : 100,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(isLargeScreen ? 16 : 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: isLargeScreen ? 28 : 18,
                ),
              ),
              SizedBox(height: isLargeScreen ? 12 : 6),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: isLargeScreen ? 14 : 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }  Widget _buildServiceCard(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap,
      bool showArrow = false,
      bool showExternalIcon = false,
      bool isLargeScreen = false}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: isLargeScreen ? 120 : 90,
          padding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? 24.0 : 12.0,
            vertical: isLargeScreen ? 16.0 : 12.0,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(isLargeScreen ? 12 : 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: isLargeScreen ? 28 : 20,
                ),
              ),
              SizedBox(width: isLargeScreen ? 20 : 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: isLargeScreen ? 16 : 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (showArrow)
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xFF9CA3AF),
                  size: 14,
                ),
              if (showExternalIcon)
                Icon(
                  Icons.open_in_new,
                  color: const Color(0xFF9CA3AF),
                  size: 14,
                ),
            ],
          ),
        ),
      ),
    );
  }
}