class uploadResponse{

  late final String message;
  late final bool success;

  uploadResponse({
    required this.message,
    required this.success,
  });

  factory uploadResponse.fromJson(Map<String,dynamic> uploadImagData){
    return uploadResponse(
      message: uploadImagData['message'], 
      success: uploadImagData['success'],
    );
  }
}