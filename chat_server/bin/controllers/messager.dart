import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../services/message_memory.dart';

class Messager {
  MessageMemory memory = MessageMemory();

  Response checkIaResponse(Request request) {
    Map<String, dynamic> res = {
      "message": memory.currentSpeaker == Current.ia &&
              memory.currentListener == Current.client
          ? memory.lastResponse
          : ''
    };

    if (res['message'] != '') {
      memory.currentListener = Current.ia;
    }

    return Response.ok(jsonEncode(res));
  }

  Response checkClientRequest(Request request) {
    Map<String, dynamic> res = {
      "message": memory.currentSpeaker == Current.client &&
              memory.currentListener == Current.ia
          ? memory.lastRequest
          : ''
    };

    if (res['message'] != '') {
      memory.currentListener = Current.client;
    }

    return Response.ok(jsonEncode(res));
  }

  Future<Response> sendResponse(Request request) async {
    memory.lastResponse = json.decode(await request.readAsString())['message'];
    memory.currentSpeaker = Current.ia;
    return Response.ok(jsonEncode({'success': true}));
  }

  Future<Response> sendMessage(Request request) async {
    memory.lastRequest = json.decode(await request.readAsString())['message'];
    memory.currentSpeaker = Current.client;
    return Response.ok(jsonEncode({'success': true}));
  }
}
