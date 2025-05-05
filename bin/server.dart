import 'dart:io';

import 'journal_api.dart';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/journals', _journalApi.listJournals)
  ..post('/journals', _journalApi.createJournal);

Response _rootHandler(Request req) => Response.ok('Hello, World!\n');

late JournalApi _journalApi;

Future<void> main(List<String> args) async {

  final dataDir = Platform.environment['JOURNAL_DIR'] ?? 'journals';
  final dataDirExists = Directory(dataDir).existsSync();
  if (!dataDirExists) {
    Directory(dataDir).createSync(recursive: true);
  }

  final journalDir = Directory(dataDir);
  _journalApi = JournalApi(journalDir);
  
    // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
