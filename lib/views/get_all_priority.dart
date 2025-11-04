import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saboor_haseeb_backend/models/priority.dart';
import 'package:saboor_haseeb_backend/models/task.dart';
import 'package:saboor_haseeb_backend/services/priority.dart';
import 'package:saboor_haseeb_backend/services/task.dart';
import 'package:saboor_haseeb_backend/views/get_priority_task.dart';

class GetAllPriorityView extends StatelessWidget {
  const GetAllPriorityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Priorities")),
      body: StreamProvider.value(
        value: PriorityServices().getAllPriorities(),
        initialData: [PriorityModel()],
        builder: (context, child) {
          List<PriorityModel> priorityList = context.watch<List<PriorityModel>>();
          return ListView.builder(
            itemCount: priorityList.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: (){

Navigator.push(context, MaterialPageRoute(builder: (context)=>GetPriorityTask(
  model: priorityList[i],
)));

                },
                leading: Icon(Icons.category),
                title: Text(priorityList[i].name.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
