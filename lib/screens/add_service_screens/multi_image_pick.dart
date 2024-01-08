import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultiImagePicker extends StatefulWidget {
  const MultiImagePicker({super.key});

  @override
  State<MultiImagePicker> createState() => _MultiImagePickerState();
}

class _MultiImagePickerState extends State<MultiImagePicker> {
  List<File> _images = [];
  List<File> _images2 = [];

  Future<void> pickImage() async {
    List pickedFiles = await ImagePicker().pickMultiImage();
    setState(() {
      _images = pickedFiles.map((file) => File(file.path)).toList();
    });
  }

  Future<void> pickImageExtra() async {
    List pickedFiles = await ImagePicker().pickMultiImage();
    setState(() {
      // List<File> _extraImages = [];
      List<File> _extraImages =
          pickedFiles.map((file) => File(file.path)).toList();
      _images.addAll(_extraImages);
    });
  }

  void removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: pickImage,
          child: const Text('Pick Images'),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < _images.length; i++)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        _images[i],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => removeImage(i),
                    ),
                  ],
                ),
            ],
          ),
        ),
        Text("hsa"),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            DottedBorder(
                // dashPattern: [1,3],
                strokeWidth: 1,
                color: Colors.grey,
                child: Container(
                  height: 120,
                  // color: Colors.grey,
                )),
            _images.length == 0
                ? InkWell(
                    onTap: () {
                      // pickImage(ImageSource.gallery,"_ffsaiImage" );
                      pickImage();
                    },
                    child:
                        // _ffsaiImage == null ?
                        DottedBorder(
                      strokeWidth: 1,
                      color: Colors.grey,
                      child: Container(
                        color: Colors.blue[50],
                        height: 75,
                        width: 75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // crossAxisAlignment:CrossAxisAlignment.stretch ,
                            children: const [
                              Icon(Icons.camera_alt),
                              Text("Add Photo"),
                            ]),
                      ),
                    ))
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            pickImageExtra();
                          },
                          child: DottedBorder(
                            strokeWidth: 1,
                            color: Colors.grey,
                            child: Container(
                              color: Colors.blue[50],
                              height: 75,
                              width: 75,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  // crossAxisAlignment:CrossAxisAlignment.stretch ,
                                  children: const [
                                    Icon(Icons.camera_alt),
                                    Text("Add Photo"),
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        for (int i = 0; i < _images.length; i++)
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DottedBorder(
                                  strokeWidth: 1,
                                  color: Colors.grey,
                                  child: Row(
                                    children: [
                                      Image.file(
                                        _images[i],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () => removeImage(i),
                              ),
                            ],
                          ),
                      ],
                    ),
                  )
          ],
        ),
      ],
    ));
  }
}
