import 'package:parse_data/parse_data.dart';
import 'package:test/test.dart';

void testIntParser() => group('Int Parser', () {
      test('should parse value as integer when value is integer', () {
        expect(Parse(1000).asInt().elseGetNull(), 1000);
        expect(Parse(2).asInt().elseGet(1), 2);
        expect(Parse(20000).asInt().elseLazyGet(() => 1), 20000);
        expect(Parse(0).asInt().elseThrow('joke'), 0);
        late final union = Parse(3).asInt().elseGetWrapper();
        expect(union.isParseable(), true);
        expect(union.unwrap(), 3);
      });
      test('''
          should fail to parse value as integer
          when value is not integer 
          and take subsequent action
          ''', () {
        expect(Parse(false).asInt().elseGetNull(), null);
        expect(Parse('string').asInt().elseGet(1), 1);
        expect(Parse(1.0).asInt().elseLazyGet(() => 90 * 90), 8100);
        expect(
            () => Parse(List<dynamic>.empty())
                .asInt()
                .elseThrow('array aint int'),
            throwsException);
        late final union = Parse(null).asInt().elseGetWrapper();
        expect(union.isParseable(), false);
        expect(union.unwrap, throwsException);
      });
    });
