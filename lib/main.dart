import 'dart:async';
import 'dart:io';
import 'package:dart_appwrite/dart_appwrite.dart';

Future main(final context) async {
  final client = Client()
      .setProject(Platform.environment['APPWRITE_FUNCTION_PROJECT_ID'])
      .setKey(context.req.headers['x-appwrite-key']);

  if (context.req.method == 'GET') {
    final result = await Users(client).list();
    return context.res.json(result.toMap());
  }

  if (context.req.method == 'POST') {
    if (context.req.bodyJson
        case {'id': String userId, 'status': bool status}) {
      await Users(client).updateStatus(userId: userId, status: status);
      return context.res.json({});
    }
  }

  return context.res.empty();
}
