import 'package:appwrite/appwrite.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FileLoad extends StatelessWidget {
  final Storage storage;
  final String _bucketId;
  final Function _getFileList;

  const FileLoad({
    Key? key,
    required this.storage,
    required String bucketId,
    required Function getFileList,
  })  : _bucketId = bucketId,
        _getFileList = getFileList,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();
          PlatformFile picFile;
          late InputFile file;

          if (result != null) {
            picFile = result.files.first;
            if (kIsWeb) {
              file = InputFile(filename: picFile.name, bytes: picFile.bytes);
            } else {
              file = InputFile(filename: picFile.name, path: picFile.path);
            }
          } else {
            // User canceled the picker
          }

          storage.createFile(
              bucketId: _bucketId,
              fileId:
                  'unique()', // use 'unique()' to automatically generate a unique ID
              file: file,
              read: ['role:all'],
              write: []).then((response) {
            print(response); // File uploaded!
            _getFileList();
          }).catchError((error) {
            print(error.response);
          });
        },
        child: Text('Add File'));
  }
}
