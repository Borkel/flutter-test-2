import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<String> _notes = [];
  final TextEditingController _controller = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addNote(String note) {
    setState(() {
      _notes.add(note);
    });
  }

  void _removeNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas App'),
      ),
      body: _selectedIndex == 0
          ? NotesPage(
        notes: _notes,
        controller: _controller,
        onAddNote: _addNote,
        onRemoveNote: _removeNote,
      )
          : const SecondPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Segunda Página',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class NotesPage extends StatelessWidget {
  final List<String> notes;
  final TextEditingController controller;
  final Function(String) onAddNote;
  final Function(int) onRemoveNote;

  const NotesPage({
    super.key,
    required this.notes,
    required this.controller,
    required this.onAddNote,
    required this.onRemoveNote,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Escribe una nota',
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    onAddNote(controller.text);
                    controller.clear();
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notes[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onRemoveNote(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Segunda Página',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
