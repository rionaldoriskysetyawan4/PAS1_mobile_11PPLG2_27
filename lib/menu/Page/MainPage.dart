import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Api/ApiController.dart';
import '../../Controller/TaskController.dart';
import '../../Model/TaskModel.dart';
import '../../Model/TeamModel.dart';
import '../CharacterPage/CharacterPage.dart';


class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    final Apicontroller apicontroller = Get.put(Apicontroller());
    final TaskController taskController = Get.put(TaskController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskController.loadTasks();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
      ),
      body: GetX<Apicontroller>(
        builder: (controller) {
          if (controller.isLoadingTeams.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.teamList.isEmpty) {
            return const Center(
              child: Text('No teams available'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: controller.teamList.length,
            itemBuilder: (context, index) {
              final team = controller.teamList[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => Characterpage(
                    image: team.badgeUrl ?? '',
                    title: team.name ?? 'Unknown Team',
                    description: team.country ?? 'No Country Information',
                  ));
                },

                child: Card(
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: team.badgeUrl?.isNotEmpty == true
                            ? Image.network(
                          team.badgeUrl!,
                          fit: BoxFit.scaleDown,
                          errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.error)),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        )
                            : const Center(child: Icon(Icons.person)),
                      ),

                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                team.name ?? 'Unknown Team',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                team.country ?? 'No Country Information',
                                style: const TextStyle(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    _addTeamAsTask(taskController, team),
                                child: const Icon(Icons.add),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _addTeamAsTask(TaskController taskController, TeamModel team) {
    TaskModel task = TaskModel(
      title: team.name ?? "Untitled Team",
      description: team.country ?? "No country details",
      imagemu: team.badgeUrl ?? "No team logo",
    );
    taskController.addTask(task);
    Get.snackbar(
      "Task Added",
      "${team.name ?? "Team"} has been added to your tasks.",
      snackPosition: SnackPosition.TOP,
    );
  }
}
