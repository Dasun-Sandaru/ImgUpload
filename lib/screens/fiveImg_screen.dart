import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

import '../models/FiveimgsHelper.dart';

class FiveImgScreen extends StatefulWidget {
  const FiveImgScreen({Key? key}) : super(key: key);

  @override
  State<FiveImgScreen> createState() => _FiveImgScreenState();
}

class _FiveImgScreenState extends State<FiveImgScreen> {


  // variables
  File? image,image1,image2,image3,image4,image5;

  String? token;

  // methods

  // pick img
  pickImage(int index) async {

    try {
      final commonImg = await ImagePicker().pickImage(source: ImageSource.camera);
      switch (index) {
        case 1:
          image1 = File(commonImg!.path);
          print('imgage 1 --> $image1');
          setState(() {
            
          });
          break;

        case 2:
          image2 = File(commonImg!.path);
          print('imgage2 --> $image2');
          setState(() {
            
          });
          break;

        case 3:
          image3 = File(commonImg!.path);
          print('imgage 3 --> $image3');
          setState(() {
            
          });
          break;

        case 4:
          image4 = File(commonImg!.path);
          print('imgage 4 --> $image4');
          setState(() {
            
          });
          break;

        case 5:
          image5 = File(commonImg!.path);
          print('imgage 5 --> $image5');
          setState(() {
            
          });
          break;

        default:
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }


  // widgets
  // img select part
  Widget _buildImgsSelect() {
    return Container(
      padding: const EdgeInsets.all(3.0),
      child: Wrap(
        spacing: 1.0,
        children: [
          //1st img
          GestureDetector(
            onTap: () {
              pickImage(1);
            },
            child: Container(
              child: image1 != null
                  ? Image.file(
                      image1!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/selfie0.png',
                      width: 100,
                      height: 100,
                    ),
            ),
          ),
          //2nd img
          GestureDetector(
            onTap: () {
              pickImage(2);
            },
            child: Container(
              child: image2 != null
                  ? Image.file(
                      image2!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/selfie1.png',
                      width: 100,
                      height: 100,
                    ),
            ),
          ),
          //3rd img
          GestureDetector(
            onTap: () {
              pickImage(3);
            },
            child: Container(
              child: image3 != null
                  ? Image.file(
                      image3!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/selfie2.png',
                      width: 100,
                      height: 100,
                    ),
            ),
          ),
          //4th img
          GestureDetector(
            onTap: () {
              pickImage(4);
            },
            child: Container(
              child: image4 != null
                  ? Image.file(
                      image4!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/selfie3.png',
                      width: 100,
                      height: 100,
                    ),
            ),
          ),
          //5th img
          GestureDetector(
            onTap: () {
              pickImage(5);
            },
            child: Container(
              child: image5 != null
                  ? Image.file(
                      image5!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/selfie4.png',
                      width: 100,
                      height: 100,
                    ),
            ),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload 5 Imgs'),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: _buildImgsSelect(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.upload,
        ),
        onPressed: () {
          // imgs upload
          FiveImgHelper fiveImgHelper = FiveImgHelper();
          fiveImgHelper.fiveImgUpload(
            token!,
            image1: image1,
            image2: image2,
            image3: image3,
            image4: image4,
            image5: image5,
          );
        },
      ),
    );
  }
}
