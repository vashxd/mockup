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
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isWebLargeScreen ? 1000 : (isWebOrTablet ? 600 : double.infinity),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isWebOrTablet ? 40 : 24,
              vertical: 20,
            ),
            child: isWebLargeScreen 
                ? _buildWebLayout()
                : _buildMobileLayout(),
          ),
        ),
      ),
    );
  }
  
  Widget _buildWebLayout() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          // Seção de imagem/banner à esquerda (apenas para telas grandes)
          Expanded(
            flex: 5,
            child: Container(
              height: 500,
              decoration: const BoxDecoration(
                color: Color(0xFF003366),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/ChatGPT Image 16 de mai. de 2025, 12_10_18.png',
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Portal do Aluno',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Acesse suas notas, atividades e mantenha-se atualizado com as informações escolares.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
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
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: _buildLoginForm(),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo e título para mobile
        Image.asset(
          'assets/logo/ChatGPT Image 16 de mai. de 2025, 12_10_18.png',
          width: 80,
          height: 80,
        ),
        const SizedBox(height: 16),
        const Text(
          'Portal do Aluno',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF003366),
          ),
        ),
        const SizedBox(height: 40),
        
        // Formulário de login
        _buildLoginForm(),
      ],
    );
  }
  
  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Bem-vindo(a)',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF003366),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Faça login para acessar sua conta',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 30),
          
          // Campo de usuário
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Usuário',
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
          ),
          const SizedBox(height: 16),
          
          // Campo de senha
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Senha',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
          ),
          const SizedBox(height: 8),
          
          // Link "Esqueceu a senha?"
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Esqueceu a senha?',
                style: TextStyle(
                  color: Color(0xFF003366),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Mensagem de erro
          if (_errorText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                _errorText,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          
          // Botão de login
          ElevatedButton(
            onPressed: _isLoading ? null : _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF003366),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              disabledBackgroundColor: const Color(0xFF003366).withOpacity(0.5),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'ENTRAR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          
          const SizedBox(height: 20),
          
          // Dica de credenciais (apenas para demonstração)
          const Text(
            'Use credenciais: admin / admin',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}