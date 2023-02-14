//import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:matterport/models/user.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:matterport/providers/user_provider.dart';
import 'package:matterport/resources/firestore_method.dart';
import 'package:open_file/open_file.dart';
import 'package:matterport/components/custom_prefix_icon.dart';
import 'package:matterport/components/custom_surfix_icon.dart';
import 'package:matterport/components/default_button.dart';
import 'package:matterport/components/form_error.dart';
import 'package:matterport/size_config.dart';
import 'package:matterport/utils/utils.dart';
import 'package:provider/provider.dart';

class Upload_Form extends StatefulWidget {
  const Upload_Form({Key? key}) : super(key: key);
  @override
  State<Upload_Form> createState() => _Upload_FormState();
}

class _Upload_FormState extends State<Upload_Form> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  final TextEditingController _propertyDetailsEditingController =
      TextEditingController();
  final TextEditingController _propertyDescriptionEditingController =
      TextEditingController();
  final TextEditingController _locationEditingController =
      TextEditingController();
  final TextEditingController _priceEditingController = TextEditingController();
  final TextEditingController _propertylinkEditingController =
      TextEditingController();
  Uint8List? video;
  FilePickerResult? file;
  List<Uint8List> _image = [];
  //final picker = ImagePicker();

  bool uploading = false;
  double val = 0;

  Future getImage() async {
    try {
      Uint8List image = await pickImage(ImageSource.gallery);
      if (image == null) return;
      setState(() {
        _image.add(image);
      });
      //final imageTemp = File(image.path);
      //setState(() => this.image = imageTemp);
      //if (image.path == null) retrieveLostData();
    } on PlatformException catch (e) {
      print('failed to pick image: $e');
    }
  }

  Future getFile() async {
    file = await FilePicker.platform.pickFiles();
    if (file == null) return;
    setState(() {
      video = file!.files.first.bytes;
    });
    //openFile(video);
  }

  /*chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLostData();
  }*/

  void postImage(String uid, String username, String profImage) async {
    /*setState(() {
      isLoading = true;
    });*/
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
          _propertyDescriptionEditingController.text,
          _propertyDetailsEditingController.text,
          _image,
          video!,
          _locationEditingController.text,
          uid,
          username,
          profImage,
          _propertylinkEditingController.text,
          _priceEditingController.text);
      if (res == "success") {
        //setState(() {
        //isLoading = false;
        //});
        showSnackBar(
          context,
          'Posted!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      //setState(() {
      //isLoading = false;
      //});
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _image = [];
    });
  }

  @override
  void dispose() {
    super.dispose();
    _propertyDetailsEditingController.dispose();
    _propertyDescriptionEditingController.dispose();
    _locationEditingController.dispose();
    _priceEditingController.dispose();
    _propertylinkEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(
      context,
    ).refreshUser();

    model.User user = Provider.of<UserProvider>(
      context,
    ).getUser;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          builddetailsFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildlocationsFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildpriceFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          builddescripeionFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildlinkFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          stackImage(),
          SizedBox(height: getProportionateScreenHeight(30)),
          getvideo(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "UPLOAD",
            press: () {
              postImage(user.uid, user.username, "user.photoUrl");
              //if (_formKey.currentState!.validate()) {
              // _formKey.currentState!.save();
              // if all are valid then go to success screen
              //Navigator.pop(context);
              //}
            },
          ),
        ],
      ),
    );
  }

  TextFormField builddetailsFormField() {
    return TextFormField(
      maxLines: 3,
      controller: _propertyDetailsEditingController,
      decoration: InputDecoration(
        labelText: "Details",
        hintText: "Enter details of property",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildlocationsFormField() {
    return TextFormField(
      //maxLines: 3,
      controller: _locationEditingController,
      decoration: InputDecoration(
        labelText: "Location",
        hintText: "Enter location of property",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon:
            CustomPrefixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildpriceFormField() {
    return TextFormField(
      //maxLines: 3,
      controller: _priceEditingController,
      decoration: InputDecoration(
        labelText: "Price",
        hintText: "Enter price of property",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon:
            CustomPrefixIcon(svgIcon: "assets/icons/naira-currency.svg"),
      ),
    );
  }

  TextFormField builddescripeionFormField() {
    return TextFormField(
      maxLines: 10,
      controller: _propertyDescriptionEditingController,
      decoration: InputDecoration(
        labelText: "Description",
        hintText: "Enter description of property",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildlinkFormField() {
    return TextFormField(
      maxLines: 10,
      controller: _propertylinkEditingController,
      decoration: InputDecoration(
        labelText: "Share Link",
        hintText: "Paste link to 3d scan",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  stackImage() {
    return Stack(
      children: [
        Container(
          height: 150,
          padding: EdgeInsets.all(4),
          child: GridView.builder(
              itemCount: _image.length + 1,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return index == 0
                    ? Center(
                        child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => !uploading ? getImage() : null),
                      )
                    : Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(_image[index - 1]),
                                fit: BoxFit.cover)),
                      );
              }),
        ),
        uploading
            ? Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Text(
                      'uploading...',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircularProgressIndicator(
                    value: val,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  )
                ],
              ))
            : Container(),
      ],
    );
  }

  getvideo() {
    return SizedBox(
      child: TextButton(
        onPressed: (() async {
          await getFile();
        }),
        child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .2,
            child: video != null
                ? ClipRect(child: Icon(Icons.verified))
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.video_camera_back,
                      color: Colors.blue,
                    ),
                  )),
      ),
    );
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}
