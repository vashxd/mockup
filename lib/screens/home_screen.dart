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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF003366),
        title: Row(
          children: [
            Image.asset(
              'assets/logo/ChatGPT Image 16 de mai. de 2025, 12_10_18.png',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 8),
            if (isWebOrTablet)
              const Text("Escola App - Portal do Aluno"),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            offset: const Offset(0, 40),
            icon: CircleAvatar(
              radius: 18,
              backgroundImage: student.profileImagePath != null
                ? AssetImage(student.profileImagePath!)
                : NetworkImage(
                    'https://placehold.co/100x100?text=${student.name[0]}',
                  ) as ImageProvider,
            ),
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.pushNamed(context, '/profile', arguments: student);
              } else if (value == 'logout') {
                // Navegando para a tela de login
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  '/login', 
                  (route) => false
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8),
                    Text('Perfil'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8),
                    Text('Sair'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            // Limitar a largura máxima do conteúdo em telas grandes
            constraints: BoxConstraints(
              maxWidth: isLargeScreen ? 1200 : double.infinity,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isWebOrTablet ? 40 : 16,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Perfil do usuário
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: isWebOrTablet ? 60 : 40,
                        backgroundImage: student.profileImagePath != null
                          ? AssetImage(student.profileImagePath!)
                          : NetworkImage(
                              'https://placehold.co/200x200?text=${student.name[0]}',
                            ) as ImageProvider,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Bem-vindo(a), ${student.name.split(' ')[0]}",
                        style: TextStyle(
                          fontSize: isWebOrTablet ? 24 : 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF003366),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Seção "MEU DIA"
                Text(
                  'MEU DIA',
                  style: TextStyle(
                    fontSize: isWebOrTablet ? 18 : 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Cards de serviço "MEU DIA" - Layout responsivo
                isLargeScreen 
                  ? _buildLargeScreenDailyServices(context)
                  : _buildMobileScreenDailyServices(context),

                const SizedBox(height: 30),
                
                // Seção "OUTROS SERVIÇOS"
                Text(
                  'OUTROS SERVIÇOS',
                  style: TextStyle(
                    fontSize: isWebOrTablet ? 18 : 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Cards de outros serviços - Layout responsivo
                isLargeScreen 
                  ? _buildLargeScreenServices(context)
                  : _buildMobileScreenServices(context),
                
                const SizedBox(height: 30),
              ],
            ),
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildServiceItem(
          context,
          icon: Icons.book,
          label: 'Atividade',
          onTap: () {
            Navigator.pushNamed(context, '/activities');
          },
          isLargeScreen: false,
        ),
        _buildServiceItem(
          context,
          icon: Icons.calendar_today,
          label: 'Calendário',
          onTap: () {
            Navigator.pushNamed(context, '/calendar');
          },
          isLargeScreen: false,
        ),
        _buildServiceItem(
          context,
          icon: Icons.chat_bubble_outline,
          label: 'Comunicação',
          onTap: () {},
          isLargeScreen: false,
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
    // Layout original para telas menores (mobile)
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
            const SizedBox(width: 16),
            Expanded(
              child: _buildServiceCard(
                context,
                icon: Icons.notifications_none,
                label: 'Notificação',
                onTap: () {
                  Navigator.pushNamed(context, '/notifications');
                },
                showArrow: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
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
            const SizedBox(width: 16),
            Expanded(
              child: _buildServiceCard(
                context,
                icon: Icons.insert_drive_file,
                label: 'Documentos',
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

  Widget _buildServiceItem(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap, bool isLargeScreen = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: isLargeScreen ? null : MediaQuery.of(context).size.width / 3.5,
        height: isLargeScreen ? 150 : 100,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4F8),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isLargeScreen ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            )
          ] : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF003366),
              size: isLargeScreen ? 42 : 28,
            ),
            SizedBox(height: isLargeScreen ? 16 : 8),
            Text(
              label,
              style: TextStyle(
                fontSize: isLargeScreen ? 18 : 14,
                fontWeight: isLargeScreen ? FontWeight.bold : FontWeight.normal,
                color: const Color(0xFF003366),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap,
      bool showArrow = false,
      bool showExternalIcon = false,
      bool isLargeScreen = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: isLargeScreen ? 120 : 80,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4F8),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isLargeScreen ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            )
          ] : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isLargeScreen ? 24.0 : 16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF003366),
                size: isLargeScreen ? 32 : 24,
              ),
              SizedBox(width: isLargeScreen ? 24 : 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: isLargeScreen ? 18 : 14,
                    fontWeight: isLargeScreen ? FontWeight.bold : FontWeight.normal,
                    color: const Color(0xFF003366),
                  ),
                ),
              ),
              if (showArrow)
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xFF003366),
                  size: isLargeScreen ? 20 : 16,
                ),
              if (showExternalIcon)
                Icon(
                  Icons.open_in_new,
                  color: const Color(0xFF003366),
                  size: isLargeScreen ? 20 : 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}