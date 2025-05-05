import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import 'journal_spec.dart';

class JournalApi {
  final Directory journalsDir;

  JournalApi(this.journalsDir);

  Response listJournals(Request request) {
    List<String> journals = [];
    if (journalsDir.existsSync()) {
      journalsDir.listSync().forEach((entity) {
        if (entity is Directory) {
          journals.add(entity.path.split(Platform.pathSeparator).last);
        }
      });
    }

    return Response.ok(jsonEncode({"journals": journals}),
        headers: {'Content-Type': 'application/json'});
  }

  Future<Response> createJournal(Request request) async {
    try {
      final body = await request.readAsString();
      final decoded = jsonDecode(body);
      final journalName = decoded['journalName'];

      if (journalName == null) {
        return Response.badRequest(
            body: 'Journal name is required in the request body');
      }

      Directory journalDir = Directory('${journalsDir.path}/$journalName');
      if (journalDir.existsSync()) {
        return Response.badRequest(
            body: 'Journal with the same name already exists');
      }

      await journalDir.create(recursive: true);

      File spec = File('${journalDir.path}/spec.json');
      await spec.create();

      final encoder = JsonEncoder.withIndent('  ');
      spec.writeAsString(encoder.convert(defaultSpec.toMap()));

      return Response.ok('Journal created successfully',
          headers: {'Content-Type': 'text/plain'});
    } catch (e) {
      return Response(500,
          body: 'Error creating journal: $e',
          headers: {'Content-Type': 'text/plain'});
    }
  }
}
