import 'dart:convert';

ResponseApi responseApiFromJson(String str) => ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
   String mesagge;
   String error;
   bool success;

  dynamic data;

  ResponseApi({
    this.mesagge,
    this.error,
    this.success,
  });

  ResponseApi.fromJson(Map<String, dynamic> json) {
    mesagge=json['message'];
    error=json['error'];
    success=json['success'];

    try{
      data=json['data'];
    }catch(e){
      print('Exception dart: $e');
    }

  }


  Map<String, dynamic> toJson() => {
    "mesagge": mesagge,
    "error": error,
    "success": success,
    "data":data
  };
}
