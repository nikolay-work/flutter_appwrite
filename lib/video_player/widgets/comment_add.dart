import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

class CommentAdd extends StatefulWidget {
  final Databases _database;
  final String _messageCollection;

  const CommentAdd({
    Key? key,
    required Databases database,
    required String messageCollection,
  })  : _database = database,
        _messageCollection = messageCollection,
        super(key: key);

  @override
  State<CommentAdd> createState() => _CommentAddState();
}

class _CommentAddState extends State<CommentAdd> {
  final _controllerName = TextEditingController( );
  final _controllerMessage = TextEditingController();

  void addComment(String name, String message) {
    widget._database.createDocument(
        collectionId: widget._messageCollection,
        documentId: 'unique()',
        data: {
          "name": name,
          "message": message,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controllerName,
          decoration: const InputDecoration(
            labelText: "Name",
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          controller: _controllerMessage,
          decoration: const InputDecoration(
            labelText: "Message",
            border: OutlineInputBorder(),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              addComment(_controllerName.value.text, _controllerMessage.value.text);
            } on AppwriteException catch (e) {
              print(e);
            }
          },
          child: Text("Press"),
        ),
      ],
    );
  }
}
