import 'package:http/http.dart' as http;

class MarketData {
  late String userid;
  late String geo_location;
  late String longitude;
  late String latitude;
  late String outlet_name;
  late String execution_type;
  late String remarks;
  late String image1;

  MarketData({
    required this.userid,
    required this.geo_location,
    required this.longitude,
    required this.latitude,
    required this.outlet_name,
    required this.execution_type,
    required this.remarks,
    required this.image1,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> marketData = Map<String, dynamic>();
    marketData['userid'] = userid;
    marketData['geo_location'] = geo_location;
    marketData['longitude'] = longitude;
    marketData['latitude'] = latitude;
    marketData['outlet_name'] = outlet_name;
    marketData['execution_type'] = execution_type;
    marketData['remarks'] = remarks;
    marketData['image1'] = image1;

    return marketData;
  }
}

class MarketResponse {
  late final String message;
  late final bool success;

  MarketResponse({
    required this.message,
    required this.success,
  });

  factory MarketResponse.fromJson(Map<String, dynamic> loginData) {
    return MarketResponse(
      message: loginData['message'],
      success: loginData['success'],
    );
  }
}
