import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgupload/models/uploadResponse.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  // variables
  // get image
  File? image;
  String? token = '';

  // widgets

  // for single img view
  Widget _buildSingleImageView() {
    return Container(
      height: 300,
      width: 300,
      child: image != null
          ? Image.file(
              image!,
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            )
          : Image.asset('assets/images/profile.png'),
    );
  }

  Widget _buildUploadButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        buttonColor: Color(0xFFee3a43), //  <-- dark color
        textTheme: ButtonTextTheme.primary,
        child: RaisedButton(
          onPressed: () {
            // upload img
            uploadImg();
          },
          child: const Text(
            'Upload',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        buttonColor: Color(0xFFee3a43), //  <-- dark color
        textTheme: ButtonTextTheme.primary,
        child: RaisedButton(
          onPressed: () {
            // select img
            pickImage();
          },
          child: const Text(
            'Select',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // methods

  // pick img
  pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // upload img
  uploadImg() async {
    var requestimg = http.MultipartRequest("POST", Uri.parse(""));

    Map<String, String> headers = {
      'Content-type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    requestimg.headers.addAll(headers);
    requestimg.fields['userid'] = '100';
    requestimg.files.add(await http.MultipartFile.fromPath('image1', image!.path));

    var response = await requestimg.send();

    // print image path
    String imgPath = image!.path;
    print(imgPath);

    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      final data = jsonDecode(res.body);

      uploadResponse uploadresponseObj = uploadResponse.fromJson(data);
      // check ok
      if (uploadresponseObj.success) {
        print('Img Uploaded');
        print(uploadresponseObj.message);
        // show toast
        Fluttertoast.showToast(
          msg: uploadresponseObj.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        print('Error :- Img not upload');
        print(uploadresponseObj.message);
        Fluttertoast.showToast(
          msg: uploadresponseObj.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      print(response.statusCode.toString());
      Fluttertoast.showToast(
        msg: response.statusCode.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'One Img Upload',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            _buildSingleImageView(),
            const SizedBox(
              height: 50.0,
            ),
            _buildSelectButton(),
            const SizedBox(
              height: 10.0,
            ),
            _buildUploadButton(),
          ],
        ),
      ),
    );
  }

}
