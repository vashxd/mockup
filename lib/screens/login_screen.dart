// Modificar a tela de login para melhor suporte ao layout web e mobile
import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorText = '';
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    setState(() {
      _isLoading = true;
    });

    // Simulação de uma pequena latência na autenticação
    Future.delayed(const Duration(milliseconds: 500), () {
      final mockData = MockData();
      final students = mockData.getStudents();
      
      // Como é um mockup, apenas redireciona para a home sem validação
      Navigator.pushReplacementNamed(
        context, 
        '/home',
        arguments: students.first,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    final isWebLargeScreen = MediaQuery.of(context).size.width > 800;
    final isWebOrTablet = MediaQuery.of(context).size.width > 600;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6366F1),
              Color(0xFF8B5CF6),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isWebLargeScreen ? 900 : (isWebOrTablet ? 500 : double.infinity),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: isWebOrTablet ? 40 : 24,
                vertical: 20,
              ),
              child: isWebLargeScreen 
                  ? _buildWebLayout()
                  : _buildMobileLayout(),
            ),
          ),
        ),
      ),
    );
  }
    Widget _buildWebLayout() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          // Seção de imagem/banner à esquerda
          Expanded(
            flex: 5,
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF6366F1),
                    Color(0xFF8B5CF6),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/logo/ChatGPT Image 16 de mai. de 2025, 12_10_18.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Portal do Aluno',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Acesse suas notas, atividades e mantenha-se atualizado com as informações escolares.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Seção do formulário de login à direita
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(48),
              child: _buildLoginForm(),
            ),
          ),
        ],
      ),
    );
  }
    Widget _buildMobileLayout() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo e título para mobile
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/logo/ChatGPT Image 16 de mai. de 2025, 12_10_18.png',
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(height: 24),            Text(
              'Portal do Aluno',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: const Color(0xFF1F2937),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Faça login para acessar sua conta',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 40),
            
            // Formulário de login
            _buildLoginForm(),
          ],
        ),
      ),
    );
  }
    Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Bem-vindo(a)',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: const Color(0xFF1F2937),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Entre com suas credenciais',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 32),
          
          // Campo de usuário
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Usuário',
              hintText: 'Digite seu usuário',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 20),
          
          // Campo de senha
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Senha',
              hintText: 'Digite sua senha',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Link "Esqueceu a senha?"
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Esqueceu a senha?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Mensagem de erro
          if (_errorText.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Text(
                _errorText,
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          
          // Botão de login
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              child: _isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'ENTRAR',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Dica de credenciais
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                Text(
                  '💡 Dica para demonstração',
                  style: TextStyle(
                    color: Color(0xFF6366F1),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Use qualquer usuário e senha para entrar',
                  style: TextStyle(
                    color: Color(0xFF6366F1),
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}