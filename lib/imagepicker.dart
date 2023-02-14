import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? image;
  bool _uploading = false;
  List<String> urllist = [];

  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> uploadFile() async {
      File file = File(image!.path);
      String imageName =
          'productImage/${DateTime.now().microsecondsSinceEpoch}';
      String downloadUrl;

      try {
        await FirebaseStorage.instance.ref(imageName).putFile(file);
        downloadUrl =
            await FirebaseStorage.instance.ref(imageName).getDownloadURL();
        if (downloadUrl != null) {
          setState(() {
            image = null;
            print(downloadUrl);
          });
        }
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cancelled")),
        );
        print(e);
      }
      //return downloadUrl;
    }

    return Dialog(
      child: Column(children: [
        AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: Text(
            'Upload Images',
            style: TextStyle(color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            image = null;
                          });
                        },
                      )),
                  Container(
                      height: 150,
                      width: double.infinity,
                      child: FittedBox(
                        child: image == null
                            ? Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              )
                            : Image.file(image!),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              if (image != null)
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          _uploading = true;
                          uploadFile(); /*.then((url) {
                            /if (url != null) {
                              setState(() {
                                _uploading = true;
                              });
                            }
                          });*/
                        },
                        child: Text('Save'),
                        color: Colors.green,
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text('Cancel'),
                        color: Colors.red.shade300,
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: GalleryImage(
                imageUrls: urllist,
              )),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    getImage();
                  },
                  color: Colors.blue,
                  child: Text('Upload Image'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
