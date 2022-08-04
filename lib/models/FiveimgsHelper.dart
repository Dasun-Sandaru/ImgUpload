import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import '../services/config.dart';
import 'marketData.dart';

class FiveImgHelper{

  Future<void> fiveImgUpload(String token, {File? image1,File? image2,File? image3,File? image4,File? image5}) async {

    print('Start FiveImaHelper clz - fiveImgUpload method'); //
    var requestimg = http.MultipartRequest("POST",Uri.parse("${Config.BACKEND_URL}market-execution"));

    Map<String, String> headers = {
      'Content-type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    requestimg.headers.addAll(headers);
    requestimg.fields['userid'] = '100';
    requestimg.fields['geo_location'] = 'locationName';
    requestimg.fields['longitude'] = 'longitude';
    requestimg.fields['latitude'] = 'latitude';
    requestimg.fields['outlet_name'] = 'longitude';
    requestimg.fields['execution_type'] = '1';
    requestimg.fields['remarks'] = 'reason';
    requestimg.fields['id'] = '1';

    // img add
    // 1 img
    if (image1?.path != null) {
      requestimg.files.add(await http.MultipartFile.fromPath('image1', image1!.path));
    }

    // 2 img
    if (image2?.path != null) {
      requestimg.files.add(await http.MultipartFile.fromPath('image2', image2!.path));
    }

    // 3 img
    if (image3?.path != null) {
      requestimg.files.add(await http.MultipartFile.fromPath('image3', image3!.path));
    }

    // 4 img
    if (image4?.path != null) {
      requestimg.files.add(await http.MultipartFile.fromPath('image4', image4!.path));
    }

    // 5 img
    if (image5?.path != null) {
      requestimg.files.add(await http.MultipartFile.fromPath('image5', image5!.path));
    }
    

    var res = await requestimg.send();
    print('Start FiveImaHelper clz - fiveImgUpload method -- send request');

    String fileName0 = image1!.path;
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
}