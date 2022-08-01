import 'package:cast_data/cast_data.dart';
import 'package:test/test.dart';

void testStringCaster() => group('String Caster', () {
      test('should cast value as string when value is string', () {
        expect(Cast('hey').asString().elseGetNull(), 'hey');
        expect(Cast('ho').asString().elseGet('hoho'), 'ho');
        expect(Cast('1').asString().elseLazyGet(() => ''), '1');
        expect(Cast('asd').asString().elseThrow('joke'), 'asd');
        final union = Cast('').asString().elseGetWrapper();
        expect(union.isCastable(), true);
        expect(union.unwrap(), '');
      });
      test('''
          should fail to cast value as string
          when value is not string 
          and take subsequent action
          ''', () {
        expect(Cast(1).asString().elseGetNull(), null);
        expect(Cast(true).asString().elseGet('abc'), 'abc');
        expect(
            Cast(List<int>.empty())
                .asString()
                .elseLazyGet(() => 'xing fu tang'),
            'xing fu tang');
        expect(
            () => Cast(List<int>.empty())
                .asString()
                .elseThrow('array aint string'),
            throwsException);
        final union = Cast(false).asString().elseGetWrapper();
        expect(union.isCastable(), false);
        expect(union.unwrap, throwsException);
      });
    });
