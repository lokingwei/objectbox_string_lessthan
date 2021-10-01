import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:objectbox_string_lessthan/objectbox.g.dart';
import 'package:objectbox_string_lessthan/objectbox_string_lessthan.dart';
import 'package:path/path.dart';

void main() async {
  test('unexpected string lessthan', () async {
    var directory = join(Directory.current.path, 'test-a');
    final dir = Directory(directory);
    if (dir.existsSync()) dir.deleteSync(recursive: true);
    final store = await openStore(directory: directory.toString());
    final box = store.box<Doc>();
    box.put(Doc(key: 'b'));
    box.put(Doc(key: 'c'));
    box.put(Doc(key: 'd'));
    expect(
        box.query(Doc_.key.greaterOrEqual('a')).build().find(), hasLength(3));
    expect(
        box.query(Doc_.key.greaterOrEqual('b')).build().find(), hasLength(3));
    expect(
        box.query(Doc_.key.greaterOrEqual('c')).build().find(), hasLength(2));
    expect(
        box.query(Doc_.key.greaterOrEqual('d')).build().find(), hasLength(1));
    expect(
        box.query(Doc_.key.greaterOrEqual('e')).build().find(), hasLength(0));

    expect(box.query(Doc_.key.lessOrEqual('a')).build().find(), hasLength(0));
    expect(box.query(Doc_.key.lessOrEqual('b')).build().find(), hasLength(1));
    expect(box.query(Doc_.key.lessOrEqual('c')).build().find(), hasLength(2));
    expect(box.query(Doc_.key.lessOrEqual('d')).build().find(), hasLength(3));
    // expected-3 fail here
    expect(box.query(Doc_.key.lessOrEqual('e')).build().find(), hasLength(3));
  });
}
