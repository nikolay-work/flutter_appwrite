import 'package:flutter/material.dart';

import '../models/comment_model.dart';

class CommentList extends StatelessWidget {
  final List<CommentModel> messagesList;

  const CommentList({
    Key? key,
    required this.messagesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reversList = messagesList.reversed.toList();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: reversList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: Text(reversList[index].name),
            subtitle: Text(reversList[index].message),
          );
        });
  }
}
