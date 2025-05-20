import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import '../models/eclass_course.dart';
import '../models/eclass_material.dart';
import '../data/mock_data.dart';

class EClassCourseDetailScreen extends StatefulWidget {
  final EClassCourse course;

  const EClassCourseDetailScreen({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  _EClassCourseDetailScreenState createState() => _EClassCourseDetailScreenState();
}

class _EClassCourseDetailScreenState extends State<EClassCourseDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MockData _mockData = MockData();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: const Color(0xFF003366),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          middle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo/ChatGPT Image 16 de mai. de 2025, 12_10_18.png',
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 8),
              const Text(
                'e-Class',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        child: _buildBody(context),
      );
    } else {
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
                'e-Class',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (Platform.isIOS) {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('Contatar Professor'),
                  content: const Text('Iniciando chat com o professor...'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Contactando professor...'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          backgroundColor: const Color(0xFF003366),
          child: const Icon(Icons.chat, color: Colors.white),
        ),
      );
    }
  }
  
  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        // Banner do curso
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo/ChatGPT Image 20 de mai. de 2025, 08_14_36.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.course.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.course.teacher,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Progress Bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Progresso: ${(widget.course.progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Platform.isIOS ? CupertinoIcons.book : Icons.book, 
                        size: 13, 
                        color: const Color(0xFF003366)
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${widget.course.materialsCount}',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Platform.isIOS ? CupertinoIcons.doc_text : Icons.assignment, 
                        size: 13, 
                        color: const Color(0xFF003366)
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${widget.course.activitiesCount}',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: widget.course.progress,
                  minHeight: 7,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    const Color(0xFF003366),
                  ),
                ),
              ),
            ],
          ),
        ),
          // Tab Bar
        Platform.isIOS 
        ? CupertinoSegmentedControl<int>(
            children: const {
              0: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('MATERIAIS', style: TextStyle(fontSize: 13)),
              ),
              1: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('ATIVIDADES', style: TextStyle(fontSize: 13)),
              ),
            },
            groupValue: _tabController.index,
            onValueChanged: (int value) {
              setState(() {
                _tabController.animateTo(value);
              });
            },
            borderColor: const Color(0xFF003366),
            selectedColor: const Color(0xFF003366),
            unselectedColor: Colors.white,
          )
        : Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFF003366),
            labelColor: const Color(0xFF003366),
            unselectedLabelColor: Colors.grey[600],
            tabs: const [
              Tab(text: 'MATERIAIS'),
              Tab(text: 'ATIVIDADES'),
            ],
          ),
        ),
        
        // Tab Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Materiais Tab
              _buildMaterialsTab(),
              
              // Atividades Tab
              _buildActivitiesTab(),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildMaterialsTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with course info
          _buildCourseHeader(),
          
          // Materials section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'MATERIAIS DO CURSO',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
          ),
            // Filter options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Platform.isIOS
                      ? GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                title: const Text('Selecione um tipo'),
                                actions: [
                                  CupertinoActionSheetAction(
                                    child: const Text('Todos os tipos'),
                                    onPressed: () {
                                      Navigator.pop(context, 'Todos');
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: const Text('Documentos'),
                                    onPressed: () {
                                      Navigator.pop(context, 'pdf');
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: const Text('Vídeos'),
                                    onPressed: () {
                                      Navigator.pop(context, 'video');
                                    },
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Todos os tipos'),
                                const Icon(CupertinoIcons.chevron_down, size: 16),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: 'Todos',
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  value: 'Todos',
                                  child: Text('Todos os tipos'),
                                ),
                                DropdownMenuItem(
                                  value: 'pdf',
                                  child: Text('Documentos'),
                                ),
                                DropdownMenuItem(
                                  value: 'video',
                                  child: Text('Vídeos'),
                                ),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Platform.isIOS
                      ? GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                title: const Text('Selecione uma ordenação'),
                                actions: [
                                  CupertinoActionSheetAction(
                                    child: const Text('Mais recentes'),
                                    onPressed: () {
                                      Navigator.pop(context, 'Recentes');
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: const Text('Mais antigos'),
                                    onPressed: () {
                                      Navigator.pop(context, 'Antigos');
                                    },
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Mais recentes'),
                                const Icon(CupertinoIcons.chevron_down, size: 16),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: 'Recentes',
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  value: 'Recentes',
                                  child: Text('Mais recentes'),
                                ),
                                DropdownMenuItem(
                                  value: 'Antigos',
                                  child: Text('Mais antigos'),
                                ),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Materials list
          _buildMaterialsList(),
        ],
      ),
    );
  }

  Widget _buildMaterialsList() {
    final materials = _mockData.getMathMaterials();
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: materials.length,
      itemBuilder: (context, index) {
        final material = materials[index];
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: material.type == 'pdf' 
                      ? Colors.red.shade100 
                      : Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),                child: Icon(
                  material.type == 'pdf' 
                      ? (Platform.isIOS ? CupertinoIcons.doc_fill : Icons.picture_as_pdf)
                      : (Platform.isIOS ? CupertinoIcons.play_rectangle_fill : Icons.video_library),
                  color: material.type == 'pdf' 
                      ? Colors.red 
                      : Colors.blue,
                ),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      material.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (material.isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'NOVO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(material.description),
                  const SizedBox(height: 8),                  Row(
                    children: [
                      Icon(
                        Platform.isIOS ? CupertinoIcons.calendar : Icons.calendar_today,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        material.date,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      if (material.isCompleted)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [                              Icon(
                                Platform.isIOS ? CupertinoIcons.checkmark_circle : Icons.check_circle,
                                size: 12,
                                color: Colors.green.shade800,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Concluído',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                // Ação ao clicar no material
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildActivitiesTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with course info
          _buildCourseHeader(),
          
          // Activities section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'ATIVIDADES DO CURSO',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
          ),
            // Filter options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Platform.isIOS
                      ? GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                title: const Text('Selecione um status'),
                                actions: [
                                  CupertinoActionSheetAction(
                                    child: const Text('Todos os status'),
                                    onPressed: () {
                                      Navigator.pop(context, 'Todos');
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: const Text('Pendentes'),
                                    onPressed: () {
                                      Navigator.pop(context, 'Pendentes');
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: const Text('Concluídas'),
                                    onPressed: () {
                                      Navigator.pop(context, 'Concluídas');
                                    },
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Todos os status'),
                                const Icon(CupertinoIcons.chevron_down, size: 16),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: 'Todos',
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  value: 'Todos',
                                  child: Text('Todos os status'),
                                ),
                                DropdownMenuItem(
                                  value: 'Pendentes',
                                  child: Text('Pendentes'),
                                ),
                                DropdownMenuItem(
                                  value: 'Concluídas',
                                  child: Text('Concluídas'),
                                ),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Platform.isIOS
                      ? GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                title: const Text('Selecione uma ordenação'),
                                actions: [
                                  CupertinoActionSheetAction(
                                    child: const Text('Por prazo'),
                                    onPressed: () {
                                      Navigator.pop(context, 'Prazos');
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: const Text('Por título'),
                                    onPressed: () {
                                      Navigator.pop(context, 'Título');
                                    },
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Por prazo'),
                                const Icon(CupertinoIcons.chevron_down, size: 16),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: 'Prazos',
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  value: 'Prazos',
                                  child: Text('Por prazo'),
                                ),
                                DropdownMenuItem(
                                  value: 'Título',
                                  child: Text('Por título'),
                                ),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Activities list
          _buildActivitiesList(),
        ],
      ),
    );
  }

  Widget _buildActivitiesList() {
    final activities = _mockData.getMathActivities();
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: activity.isCompleted
                      ? Colors.green.shade100
                      : Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),                child: Icon(
                  activity.isCompleted
                      ? (Platform.isIOS ? CupertinoIcons.checkmark_circle : Icons.task_alt)
                      : (Platform.isIOS ? CupertinoIcons.clock : Icons.pending_actions),
                  color: activity.isCompleted
                      ? Colors.green
                      : Colors.orange,
                ),
              ),
              title: Text(
                activity.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(activity.description),
                  const SizedBox(height: 8),
                  Row(                    children: [
                      Icon(
                        Platform.isIOS ? CupertinoIcons.calendar : Icons.calendar_today,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Prazo: ${activity.dueDate}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      if (activity.isCompleted)
                        Row(
                          children: [
                            const Text(
                              'Nota: ',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${activity.grade}/${activity.maxGrade}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: activity.grade! >= activity.maxGrade * 0.6
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  if (activity.isLate && activity.isCompleted)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Entregue com atraso',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red.shade800,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                // Ação ao clicar na atividade
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCourseHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/logo/ChatGPT Image 20 de mai. de 2025, 08_14_36.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.course.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003366),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.course.teacher,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),                      Row(
                      children: [
                        Icon(
                          Platform.isIOS ? CupertinoIcons.book : Icons.book,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.course.materialsCount} materiais',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Platform.isIOS ? CupertinoIcons.doc_text : Icons.assignment,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.course.activitiesCount} atividades',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Progresso do Curso',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: widget.course.progress,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF003366)),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${(widget.course.progress * 100).toInt()}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}