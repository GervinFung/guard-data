import 'package:guard_data/guard_data.dart';
import 'package:test/test.dart';

void testStringGuarder() => group('String Guarder', () {
      test('should guard value as string when value is string', () {
        expect(Guard('hey').asString().elseGetNull(), 'hey');
        expect(Guard('ho').asString().elseGet('hoho'), 'ho');
        expect(Guard('1').asString().elseLazyGet(() => ''), '1');
        expect(Guard('asd').asString().elseThrow('joke'), 'asd');
        final union = Guard('').asString().elseGetWrapper();
        expect(union.isGuardable(), true);
        expect(union.unwrap(), '');
      });
      test('''
          should fail to guard value as string
          when value is not string 
          and take subsequent action
          ''', () {
        expect(Guard(1).asString().elseGetNull(), null);
        expect(Guard(true).asString().elseGet('abc'), 'abc');
        expect(
            Guard(List<int>.empty())
                .asString()
                .elseLazyGet(() => 'xing fu tang'),
            'xing fu tang');
        expect(
            () => Guard(List<int>.empty())
                .asString()
                .elseThrow('array aint string'),
            throwsException);
        final union = Guard(false).asString().elseGetWrapper();
        expect(union.isGuardable(), false);
        expect(union.unwrap, throwsException);
      });
    });
