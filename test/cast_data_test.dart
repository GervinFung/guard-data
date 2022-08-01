import 'package:test/test.dart';

import 'cast/data_structure/list.dart';
import 'cast/primitive/boolean.dart';
import 'cast/primitive/double.dart';
import 'cast/primitive/int.dart';
import 'cast/primitive/number.dart';
import 'cast/primitive/string.dart';

void main() {
  group('Caster Functionalities Test -', () {
    group('Primitive -', () {
      testStringCaster();
      testBooleanCaster();
      testNumberCaster();
      testDoubleCaster();
      testIntCaster();
    });
    group('Data Structure -', testListCaster);
  });
}
