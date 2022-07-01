import 'package:parse_data/parse_data.dart';
import 'package:test/test.dart';

void testStringParser() => group('String Parser', () {
      test('should parse value as string when value is string', () {
        expect(Parse('hey').asString().elseGetNull(), 'hey');
        expect(Parse('ho').asString().elseGet('hoho'), 'ho');
        expect(Parse('1').asString().elseLazyGet(() => ''), '1');
        expect(Parse('asd').asString().elseThrow('joke'), 'asd');
        final union = Parse('').asString().elseGetWrapper();
        expect(union.isParseable(), true);
        expect(union.unwrap(), '');
      });
      test('''
          should fail to parse value as string
          when value is not string 
          and take subsequent action
          ''', () {
        expect(Parse(1).asString().elseGetNull(), null);
        expect(Parse(true).asString().elseGet('abc'), 'abc');
        expect(
            Parse(List<int>.empty())
                .asString()
                .elseLazyGet(() => 'xing fu tang'),
            'xing fu tang');
        expect(
            () => Parse(List<int>.empty())
                .asString()
                .elseThrow('array aint string'),
            throwsException);
        final union = Parse(false).asString().elseGetWrapper();
        expect(union.isParseable(), false);
        expect(union.unwrap, throwsException);
      });
    });
