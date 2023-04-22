import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_view_controller/flutter_view_controller.dart';

class HttpClient {
  Dio dioClient = Dio();
  Plug<String> onReceiveMessage = Plug();

  void sendMessage(String message) async {
    dioClient.post('http://localhost:8080/clientMessage',
        data: {'message': message});
    await Future.delayed(const Duration(seconds: 1));
    listenResponse();
  }

  void listenResponse() async {
    Response response = await dioClient.get('http://localhost:8080/iaResponse');
    Map<String, dynamic> json = jsonDecode(response.data);
    if (json['message'] != '') {
      onReceiveMessage.send(json['message']);
    } else {
      await Future.delayed(const Duration(seconds: 1));
      listenResponse();
    }
  }
}
