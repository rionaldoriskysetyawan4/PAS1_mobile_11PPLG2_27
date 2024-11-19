import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/TaskController.dart';

class Secondpage extends StatelessWidget {
  const Secondpage({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        backgroundColor: const Color(0xFF8E8E8E),
      ),
      body: Obx(() {
        if (taskController.tasks.isEmpty) {
          return const Center(
            child: Text(
              'No tasks added yet',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          );
        }

        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: task.imagemu != null &&
                      task.imagemu!.isNotEmpty &&
                      task.imagemu != 'No team logo'
                      ? Image.network(
                    task.imagemu!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, color: Colors.red),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                      : const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
                title: Text(
                  task.title ?? 'Untitled Task',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  task.description ?? 'No description provided',
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    if (task.id != null) {
                      taskController.deleteTask(task.id!);
                      Get.snackbar(
                        "Task Deleted",
                        "${task.title ?? 'Task'} has been removed.",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      Get.snackbar(
                        "Error",
                        "Task ID is invalid",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
