import 'package:test/test.dart';

import 'guard/data_structure/list.dart';
import 'guard/primitive/boolean.dart';
import 'guard/primitive/double.dart';
import 'guard/primitive/int.dart';
import 'guard/primitive/number.dart';
import 'guard/primitive/string.dart';

void main() {
  group('Guarder Functionalities Test -', () {
    group('Primitive -', () {
      testStringGuarder();
      testBooleanGuarder();
      testNumberGuarder();
      testDoubleGuarder();
      testIntGuarder();
    });
    group('Data Structure -', testListGuarder);
  });
}
