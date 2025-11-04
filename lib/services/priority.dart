import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saboor_haseeb_backend/models/priority.dart';

class PriorityServices {
  Stream<List<PriorityModel>> getAllPriorities() {
    return FirebaseFirestore.instance
        .collection('priorityCollection')
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => PriorityModel.fromJson(taskJson.data()))
              .toList(),
        );
  }
}
