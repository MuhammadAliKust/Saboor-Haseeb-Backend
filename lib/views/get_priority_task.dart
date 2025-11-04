import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saboor_haseeb_backend/models/priority.dart';
import 'package:saboor_haseeb_backend/models/task.dart';
import 'package:saboor_haseeb_backend/services/task.dart';

class GetPriorityTask extends StatelessWidget {
  final PriorityModel model;
  const GetPriorityTask({super.key,required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Priority Task")),
      body: StreamProvider.value(
        value: TaskServices().getPriorityTask(model.docId.toString()),
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
              );
            },
          );
        },
      ),
    );
  }
}
