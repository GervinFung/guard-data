import 'package:parse_data/parse_data.dart';
import 'package:test/test.dart';

void testDoubleParser() => group('Double Parser', () {
      test('should parse value as double when value is double', () {
        expect(Parse(1.12).asDouble().elseGetNull(), 1.12);
        expect(Parse(2.2).asDouble().elseGet(2.222), 2.2);
        expect(Parse(20000.22).asDouble().elseLazyGet(() => 3.3), 20000.22);
        expect(
            Parse(1000.99999999).asDouble().elseThrow('joke'), 1000.99999999);
        late final union = Parse(3.142).asDouble().elseGetWrapper();
        expect(union.isParseable(), true);
        expect(union.unwrap(), 3.142);
      });
      test('''
          should fail to parse value as double
          when value is not double 
          and take subsequent action
          ''', () {
        expect(Parse(true).asDouble().elseGetNull(), null);
        expect(Parse('string').asDouble().elseGet(2.22222), 2.22222);
        expect(Parse(1).asDouble().elseLazyGet(() => 1.0 + 1), 2);
        expect(
            () => Parse(List<int>.empty())
                .asDouble()
                .elseThrow('array aint double'),
            throwsException);
        late final union = Parse(null).asDouble().elseGetWrapper();
        expect(union.isParseable(), false);
        expect(union.unwrap, throwsException);
      });
    });
