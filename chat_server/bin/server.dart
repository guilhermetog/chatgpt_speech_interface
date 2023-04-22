import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'controllers/messager.dart';
import 'middleware/allow_cors.dart';
import 'package:shelf_static/shelf_static.dart';

final staticRouter = Router()
  ..mount('/', createStaticHandler('web/', defaultDocument: 'index.html'));

final _router = Router()
  ..mount('/web', staticRouter)
  ..get('/', _serveIndexHtml)
  ..get('/clientMessage', Messager().checkClientRequest)
  ..get('/iaResponse', Messager().checkIaResponse)
  ..post('/clientMessage', Messager().sendMessage)
  ..post('/iaResponse', Messager().sendResponse);

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(AllowCors())
      .addHandler(_router);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}

Response _serveIndexHtml(Request request) {
  return Response.ok(File('web/index.html').readAsStringSync(),
      headers: {'content-type': 'text/html'});
}
