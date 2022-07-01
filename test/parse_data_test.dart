import 'package:test/test.dart';

import 'parser/data_structure/list.dart';
import 'parser/non_data_structure/boolean.dart';
import 'parser/non_data_structure/double.dart';
import 'parser/non_data_structure/int.dart';
import 'parser/non_data_structure/number.dart';
import 'parser/non_data_structure/string.dart';

void main() {
  group('Parser Functionalities Test -', () {
    group('Non Data Structure -', () {
      testStringParser();
      testBooleanParser();
      testNumberParser();
      testDoubleParser();
      testIntParser();
    });
    group('Data Structure -', testListParser);
  });
}
