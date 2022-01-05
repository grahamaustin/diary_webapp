import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_webapp/model/diary.dart';
import 'package:flutter/material.dart';

class DeleteEntryDialogue extends StatelessWidget {
  const DeleteEntryDialogue({
    Key? key,
    required this.diariesCollectionReference,
    required this.diary,
  }) : super(key: key);

  final CollectionReference<Object?> diariesCollectionReference;
  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete Entry',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
      ),
      content: const Text(
        'Are you sure you want to permanently delete this entry?\nThis action cannot be reversed',
        style: TextStyle(height: 1.5),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
            onPressed: () {
              diariesCollectionReference.doc(diary.id).delete().then(
                (value) {
                  return Navigator.of(context).pop();
                },
              );
            },
            child: const Text('Delete'))
      ],
    );
  }
}
