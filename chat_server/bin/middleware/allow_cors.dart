import 'package:shelf/shelf.dart';

class AllowCors {
  Handler call(Handler innerHandler) {
    return (request) async {
      final response = innerHandler(request);

      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, DELETE, OPTIONS',
          'Access-Control-Allow-Headers': 'Origin, Content-Type',
        });
      }

      return response;
    };
  }
}
