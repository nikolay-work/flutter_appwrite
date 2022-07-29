import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'file_load.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key? key}) : super(key: key);

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late final Client _client;
  late final Storage storage;
  List<File> filesList = [];
  final String _projectId = '62e15a9067e24b70c9a3';
  String _endpoint = 'http://10.0.2.2:90/v1';
  final String _bucketId = '62e2d5e1a09cbbfe49dd';

  @override
  void initState() {
    super.initState();
    if (defaultTargetPlatform != TargetPlatform.android) {
      _endpoint = 'http://localhost:90/v1';
    }
    _client = Client()
        .setEndpoint(_endpoint) // your endpoint
        .setProject(_projectId);
    Account(_client).createAnonymousSession();
    storage = Storage(_client);

    loadFiles();
  }

  void loadFiles() {
    Future result = storage.listFiles(
      bucketId: _bucketId,
    );
    result.then((response) {
      filesList = response.files;
      setState(() {});
    }).catchError((error) {
      print(error.response);
    });
  }

  void deleteFile(String fileId) {
    Future result = storage.deleteFile(
      bucketId: _bucketId,
      fileId: fileId,
    );
    result.then((response) {
      loadFiles();
      setState(() {});
    }).catchError((error) {
      print(error.response);
    });
  }

  void updateFile(String fileId) {
    Future result = storage.updateFile(
      bucketId: _bucketId,
      fileId: fileId,
      write: ['role:all'],
      read: ['role:all'],
    );
    result.then((response) {
      loadFiles();
      setState(() {});
    }).catchError((error) {
      print(error.response);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final List<Map> myProducts =
    //     List.generate(15, (index) => {"id": index, "name": "Product $index"})
    //         .toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filesList.length,
              itemBuilder: (BuildContext ctx, index) {
                return Row(
                  children: [
                    Text(
                      filesList[index].name,
                      style: const TextStyle(color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () {
                        updateFile(filesList[index].$id);
                      },
                      icon: const Icon(
                        Icons.change_circle_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteFile(filesList[index].$id);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                );
              }),
          FileLoad(
            storage: storage,
            bucketId: _bucketId,
            getFileList: loadFiles,
          ),
        ],
      ),
    );
  }
}
