import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saboor_haseeb_backend/models/task.dart';
import 'package:saboor_haseeb_backend/services/task.dart';
import 'package:saboor_haseeb_backend/views/create_task.dart';
import 'package:saboor_haseeb_backend/views/get_completed_task.dart';
import 'package:saboor_haseeb_backend/views/get_in_completed_task.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetCompletedTaskView()),
              );
            },
            icon: Icon(Icons.circle),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GetInCompletedTaskView(),
                ),
              );
            },
            icon: Icon(Icons.incomplete_circle),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTaskView()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: TaskServices().getAllTask(),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[i].title.toString()),
                subtitle: Text(taskList[i].description.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(value: taskList[i].isCompleted, onChanged: (val) async {
                        try {
                          await TaskServices().markTaskAsComplete(taskList[i]).then((
                            val,
                          ) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Task has been marked as completed successfully",
                                ),
                              ),
                            );
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                     ),
                    IconButton(
                      onPressed: () async {
                        try {
                          await TaskServices().deleteTask(taskList[i]).then((
                            val,
                          ) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Task has been deleted successfully",
                                ),
                              ),
                            );
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
