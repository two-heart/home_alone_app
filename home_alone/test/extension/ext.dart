import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

typedef ObjectMapper<T> = T Function(Map<String, dynamic>);

extension TestUtil on String {
  Future<T> toJsonObject<T>(ObjectMapper<T> convert) async {
    var file = new File("test/resources/$this");
    var content = await file.readAsString();
    return convert(jsonDecode(content));
  }

  Future<List<T>> toJsonList<T>(ObjectMapper<T> convert) async {
    var file = new File("test/resources/$this");
    var content = await jsonDecode(await file.readAsString()) as List<dynamic>;
    return content.map((e) => convert(e)).toList();
  }
}
