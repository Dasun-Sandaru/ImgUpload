import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgupload/models/uploadResponse.dart';

import '../models/marketData.dart';
import '../services/config.dart';
import '../services/sharedPref.dart';

import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart' as pathpackage;

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  // variables
  // get image
  File? image;
  File? image1, image2, image3, image4, image5;
  String? token = '';

  @override
  void initState() {
    // read token
    getToken();
    super.initState();
  }

  // get token
  getToken() async {
    SharedPref sharedPref = SharedPref();
    token = (await sharedPref.readToken())!;
  }

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
            //uploadImg();
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


  Widget _buildDeleteButton() {
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
            //uploadImg();

            deleteImgFromGallery(image!.path);
          },
          child: const Text(
            'Delete Img',
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
      if (image == null) {
      } else {
        final imageTemp = File(renameFilePath(image));
        setState(() => this.image = imageTemp);
      }
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
    requestimg.files
        .add(await http.MultipartFile.fromPath('image1', image!.path));

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

  // upload img without user inputs...
  void uploadImage() async {
    var requestimg = http.MultipartRequest(
        "POST", Uri.parse("${Config.BACKEND_URL}market-execution"));

    Map<String, String> headers = {
      'Content-type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    print(token);

    requestimg.headers.addAll(headers);
    requestimg.fields['userid'] = '100';
    requestimg.fields['geo_location'] = 'locationName';
    requestimg.fields['longitude'] = 'longitude';
    requestimg.fields['latitude'] = 'latitude';
    requestimg.fields['outlet_name'] = 'longitude';
    requestimg.fields['execution_type'] = '1';
    requestimg.fields['remarks'] = 'reason';
    requestimg.fields['id'] = '1';
    requestimg.files
        .add(await http.MultipartFile.fromPath('image2', image!.path));

    var res = await requestimg.send();

    String fileName0 = image!.path;
    print(fileName0);

    if (res.statusCode == 200) {
      final res_ = await http.Response.fromStream(res);
      final parsed = json.decode(res_.body);
      final imgresponse = MarketResponse.fromJson(parsed);
      if (imgresponse.success) {
        print('work');
        // show toast
        Fluttertoast.showToast(
          msg: imgresponse.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        print('erorr: ------------------');
      }
    } else {
      print(res.statusCode.toString());
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
            _buildDeleteButton(),
          ],
        ),
      ),
    );
  }

  // testing

  // rename file name
  String renameFilePath(var commonImg) {
    print('imgage  <--> $image');

    String dir = pathpackage.dirname(commonImg.path);
    print('dir galley $dir');
    String newName = pathpackage.join(dir, '100-${DateTime.now()}.png');
    File(commonImg.path).renameSync(newName);

    print('New File Name ---> $newName');
    GallerySaver.saveImage(newName, albumName: "ImgUploadApp");

    return newName;
  }

    // delete img from gallery
  deleteImgFromGallery(String deleteImgFromGalleryImgPath) {
    // final dir = Directory(
    //     '/Internal storage/Pictures/AttendanceApp/100-2022-08-26 17:09:10.627951.png');
    final dir = Directory(deleteImgFromGalleryImgPath);
    // dir.deleteSync(recursive: true);
    //File('/Internal storage/Pictures/AttendanceApp/100-2022-08-26 17:09:10.627951.png').deleteSync();
    dir.delete(recursive: true);
  }
}
