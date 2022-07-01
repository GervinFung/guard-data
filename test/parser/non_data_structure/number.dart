import 'package:parse_data/parse_data.dart';
import 'package:test/test.dart';

void testNumberParser() => group('Number Parser', () {
      test('should parse value as number when value is number', () {
        expect(Parse(1.12).asNumber().elseGetNull(), 1.12);
        expect(Parse(2.2).asNumber().elseGet(1), 2.2);
        expect(Parse(20000).asNumber().elseLazyGet(() => 100), 20000);
        expect(Parse(1000).asNumber().elseThrow('joke'), 1000);
        final union = Parse(3.241).asNumber().elseGetWrapper();
        expect(union.isParseable(), true);
        expect(union.unwrap(), 3.241);
      });
      test('''
          should fail to parse value as number
          when value is not number 
          and take subsequent action
          ''', () {
        expect(Parse(true).asNumber().elseGetNull(), null);
        expect(Parse('string').asNumber().elseGet(1), 1);
        expect(Parse(List<int>.empty()).asNumber().elseLazyGet(() => 1 + 1), 2);
        expect(
            () => Parse(List<int>.empty())
                .asNumber()
                .elseThrow('array aint number'),
            throwsException);
        final union = Parse(null).asNumber().elseGetWrapper();
        expect(union.isParseable(), false);
        expect(union.unwrap, throwsException);
      });
    });
