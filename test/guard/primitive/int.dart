import 'package:guard_data/guard_data.dart';
import 'package:test/test.dart';

void testIntGuarder() => group('Int Guarder', () {
      test('should guard value as integer when value is integer', () {
        expect(Guard(1000).asInt().elseGetNull(), 1000);
        expect(Guard(2).asInt().elseGet(1), 2);
        expect(Guard(20000).asInt().elseLazyGet(() => 1), 20000);
        expect(Guard(0).asInt().elseThrow('joke'), 0);
        final union = Guard(3).asInt().elseGetWrapper();
        expect(union.isGuardable(), true);
        expect(union.unwrap(), 3);
      });
      test('''
          should fail to guard value as integer
          when value is not integer 
          and take subsequent action
          ''', () {
        expect(Guard(false).asInt().elseGetNull(), null);
        expect(Guard('string').asInt().elseGet(1), 1);
        expect(Guard(1.0).asInt().elseLazyGet(() => 90 * 90), 8100);
        expect(
            () =>
                Guard(List<dynamic>.empty()).asInt().elseThrow('array aint int'),
            throwsException);
        final union = Guard(null).asInt().elseGetWrapper();
        expect(union.isGuardable(), false);
        expect(union.unwrap, throwsException);
      });
    });
