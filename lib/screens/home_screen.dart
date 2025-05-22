import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/bloc/todo/todo_cubit.dart';
import 'package:flutter_todo_app/bloc/todo/todo_state.dart';
import 'package:flutter_todo_app/models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  void _showEditDialog(TodoModel todo) {
    final TextEditingController editingController = TextEditingController(text: todo.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFF2C2C2C),
          title: Text(
            'Editar tarefa',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: editingController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Novo Titulo da tarefa',
              hintStyle: TextStyle(color: Colors.white54),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white30),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final newTitle = editingController.text.trim();
                if (newTitle.isNotEmpty) {
                  context.read<TodoCubit>().editTodo(todo.id, newTitle);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
              ),
              child: Text('Salvar', style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Minha Todo List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Digite uma nova tarefa',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF2C2C2C),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  final text = _controller.text.trim();
                  if (text.isNotEmpty) {
                    context.read<TodoCubit>().addTodo(text);
                    _controller.clear();
                  }
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Adicionar tarefa'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<TodoCubit, TodoState>(
                builder: (context, state) {
                  final pendingTasks =
                      state.taskList.where((t) => !t.isDone).toList();
                  final completedTasks =
                      state.taskList.where((t) => t.isDone).toList();

                  return ListView(
                    children: [
                      if (pendingTasks.isNotEmpty) ...[
                        const Text(
                          'A Fazer',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...pendingTasks.map((todo) => _buildTaskCard(todo)),
                        const SizedBox(height: 16),
                      ],
                      if (completedTasks.isNotEmpty) ...[
                        const Text(
                          'Concluídas',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...completedTasks.map((todo) => _buildTaskCard(todo)),
                      ],
                      if (pendingTasks.isEmpty && completedTasks.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 32),
                            child: Text(
                              'Nenhuma tarefa ainda...',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(TodoModel todo) {
    return Card(
      color: const Color(0xFF2B2B2B),
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (_) {
            context.read<TodoCubit>().toggleTodo(todo.id);
          },
          activeColor: Colors.deepPurpleAccent,
          checkColor: Colors.white,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            color: Colors.white,
            decoration: todo.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.redAccent,),
              onPressed: () => _showEditDialog(todo),
              ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.redAccent,),
              onPressed: () {
                context.read<TodoCubit>().deleteTodo(todo.id);
              },
              ), 
          ],
        ),
      ),
    );
  }

  
}
