import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/document.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DocumentsScreen extends StatelessWidget {
  final Student student;
  final List<Document> documents;

  const DocumentsScreen({
    Key? key,
    required this.student,
    required this.documents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Detectar se estamos em uma tela grande (web)
    final isLargeScreen = MediaQuery.of(context).size.width > 800;
    final isWebOrTablet = MediaQuery.of(context).size.width > 600;
    
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
              'Documentos',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundImage: student.profileImagePath != null
              ? AssetImage(student.profileImagePath!)
              : NetworkImage(
                  'https://placehold.co/100x100?text=${student.name[0]}',
                ) as ImageProvider,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isLargeScreen ? 1200 : double.infinity,
            ),
            padding: EdgeInsets.all(isWebOrTablet ? 32 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cabeçalho
                if (isLargeScreen)
                  _buildWebHeader()
                else
                  _buildMobileHeader(),
                  
                const SizedBox(height: 20),
                
                // Categorias de Documentos
                _buildDocumentCategories(context, isWebOrTablet),
                
                const SizedBox(height: 24),
                
                // Grid ou Lista de documentos
                isWebOrTablet 
                  ? _buildDocumentsGrid(context) 
                  : _buildDocumentsList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildWebHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Documentos Disponíveis',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                student.name,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Ensino Fundamental - ${student.grade} - ${student.period} - ${student.classId}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        
        // Botões de ação para web
        ElevatedButton.icon(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF003366),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.upload_file),
          label: const Text('Enviar Documento'),
        ),
      ],
    );
  }

  Widget _buildMobileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Documentos Disponíveis',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            student.name,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Ensino Fundamental - ${student.grade} - ${student.period} - ${student.classId}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildDocumentCategories(BuildContext context, bool isWebOrTablet) {
    final categories = [
      {'icon': Icons.description_outlined, 'name': 'Meus Documentos', 'isSelected': true},
      {'icon': Icons.history, 'name': 'Histórico', 'isSelected': false},
      {'icon': Icons.school_outlined, 'name': 'Documentos Acadêmicos', 'isSelected': false},
      {'icon': Icons.payments_outlined, 'name': 'Financeiro', 'isSelected': false},
    ];
    
    if (isWebOrTablet) {
      // Versão horizontal para web/tablet
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: categories.map((category) {
            final isSelected = category['isSelected'] as bool;
            return Padding(
              padding: const EdgeInsets.only(right: 32),
              child: InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          category['icon'] as IconData,
                          color: isSelected ? const Color(0xFF003366) : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category['name'] as String,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 16,
                            color: isSelected ? const Color(0xFF003366) : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (isSelected)
                      Container(
                        width: 32,
                        height: 3,
                        decoration: BoxDecoration(
                          color: const Color(0xFF003366),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    } else {
      // Versão de chips para mobile
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: categories.map((category) {
              final isSelected = category['isSelected'] as bool;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF003366) : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFF003366),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          category['icon'] as IconData,
                          size: 18,
                          color: isSelected ? Colors.white : const Color(0xFF003366),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category['name'] as String,
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF003366),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }
  
  Widget _buildDocumentsGrid(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.3,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final document = documents[index];
        return _buildDocumentCardWeb(document);
      },
    );
  }
  
  Widget _buildDocumentCardWeb(Document document) {
    final fileExtension = document.fileName.split('.').last.toLowerCase();
    Color cardColor;
    IconData fileIcon;
    
    switch (fileExtension) {
      case 'pdf':
        cardColor = Colors.red[50]!;
        fileIcon = Icons.picture_as_pdf;
        break;
      case 'doc':
      case 'docx':
        cardColor = Colors.blue[50]!;
        fileIcon = Icons.description;
        break;
      case 'xls':
      case 'xlsx':
        cardColor = Colors.green[50]!;
        fileIcon = Icons.table_chart;
        break;
      case 'jpg':
      case 'jpeg':
      case 'png':
        cardColor = Colors.purple[50]!;
        fileIcon = Icons.image;
        break;
      default:
        cardColor = Colors.grey[100]!;
        fileIcon = Icons.insert_drive_file;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      fileIcon,
                      color: cardColor == Colors.red[50] ? Colors.red : 
                        cardColor == Colors.blue[50] ? Colors.blue :
                        cardColor == Colors.green[50] ? Colors.green :
                        cardColor == Colors.purple[50] ? Colors.purple :
                        Colors.grey[700],
                      size: 28,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.download, color: Color(0xFF003366)),
                    onPressed: () {},
                    tooltip: 'Baixar',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                document.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                document.fileName,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                document.date,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildDocumentsList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final document = documents[index];
        return ListTile(
          leading: _getFileIcon(document.fileName),
          title: Text(document.title),
          subtitle: Text(document.date),
          trailing: IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {},
            color: const Color(0xFF003366),
          ),
          onTap: () {},
        );
      },
    );
  }

  Widget _getFileIcon(String fileName) {
    final fileExtension = fileName.split('.').last.toLowerCase();
    
    Color iconColor;
    IconData iconData;
    
    switch (fileExtension) {
      case 'pdf':
        iconColor = Colors.red;
        iconData = Icons.picture_as_pdf;
        break;
      case 'doc':
      case 'docx':
        iconColor = Colors.blue;
        iconData = Icons.description;
        break;
      case 'xls':
      case 'xlsx':
        iconColor = Colors.green;
        iconData = Icons.table_chart;
        break;
      case 'jpg':
      case 'jpeg':
      case 'png':
        iconColor = Colors.purple;
        iconData = Icons.image;
        break;
      default:
        iconColor = Colors.grey;
        iconData = Icons.insert_drive_file;
    }
    
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, color: iconColor),
    );
  }
}