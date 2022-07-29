import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
// import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

import '../models/comment_model.dart';
import 'comment_add.dart';
import 'comment_list.dart';

class Comments extends StatefulWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  late final Client _client;
  late RealtimeSubscription? _subscription;
  final List<CommentModel> _messagesList = [];
  final String _messageCollection = '62e15d5f08455ce23b80';
  final String _databaseId = '62e15d365f440246613c';
  final String _projectId = '62e15a9067e24b70c9a3';
  String _endpoint = 'http://10.0.2.2:90/v1';
  late final Databases _database;

  void subscriptionEvents() {
    _subscription?.stream.listen((response) {
      if (response.payload.isNotEmpty &&
          response.events
              .contains("databases.*.collections.*.documents.*.create")) {
        _messagesList.add(CommentModel(
            name: response.payload["name"],
            message: response.payload["message"]));
        if (_messagesList.length > 10) {
          _messagesList.removeAt(0);
        }
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (defaultTargetPlatform != TargetPlatform.android) {
      _endpoint = 'http://localhost:90/v1';
    }
    _client = Client()
        .setEndpoint(_endpoint) // your endpoint
        .setProject(_projectId);
    _database = Databases(_client, databaseId: _databaseId);
    Account(_client).createAnonymousSession();
    _subscription = Realtime(_client).subscribe(
        ['databases.$_databaseId.collections.$_messageCollection.documents']);

    subscriptionEvents();
  }

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text("Коментарии"),
          CommentList(messagesList: _messagesList),
          CommentAdd(
              database: _database, messageCollection: _messageCollection),
        ],
      ),
    );
  }
}
