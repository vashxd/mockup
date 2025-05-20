import 'package:flutter/material.dart';
import '../models/student.dart';

class HomeScreen extends StatelessWidget {
  final Student student;

  const HomeScreen({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: student.profileImagePath != null
                      ? AssetImage(student.profileImagePath!)
                      : NetworkImage(
                          'https://placehold.co/200x200?text=${student.name[0]}',
                        ) as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    student.name.split(' ')[0],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'MEU DIA',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildServiceItem(
                  context,
                  icon: Icons.book,
                  label: 'Atividade',
                  onTap: () {
                    Navigator.pushNamed(context, '/activities');
                  },
                ),
                _buildServiceItem(
                  context,
                  icon: Icons.calendar_today,
                  label: 'Calendário',
                  onTap: () {
                    Navigator.pushNamed(context, '/calendar');
                  },
                ),
                _buildServiceItem(
                  context,
                  icon: Icons.chat_bubble_outline,
                  label: 'Comunicação',
                  onTap: () {},
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'OUTROS SERVIÇOS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
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
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF003366),
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF003366),
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
      bool showExternalIcon = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF003366),
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF003366),
                  ),
                ),
              ),
              if (showArrow)
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF003366),
                  size: 16,
                ),
              if (showExternalIcon)
                const Icon(
                  Icons.open_in_new,
                  color: Color(0xFF003366),
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}