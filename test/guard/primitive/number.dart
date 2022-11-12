import 'package:guard_data/guard_data.dart';
import 'package:test/test.dart';

void testNumberGuarder() => group('Number Guarder', () {
      test('should guard value as number when value is number', () {
        expect(Guard(1.12).asNumber().elseGetNull(), 1.12);
        expect(Guard(2.2).asNumber().elseGet(1), 2.2);
        expect(Guard(20000).asNumber().elseLazyGet(() => 100), 20000);
        expect(Guard(1000).asNumber().elseThrow('joke'), 1000);
        final union = Guard(3.241).asNumber().elseGetWrapper();
        expect(union.isGuardable(), true);
        expect(union.unwrap(), 3.241);
      });
      test('''
          should fail to guard value as number
          when value is not number 
          and take subsequent action
          ''', () {
        expect(Guard(true).asNumber().elseGetNull(), null);
        expect(Guard('string').asNumber().elseGet(1), 1);
        expect(Guard(List<int>.empty()).asNumber().elseLazyGet(() => 1 + 1), 2);
        expect(
            () => Guard(List<int>.empty())
                .asNumber()
                .elseThrow('array aint number'),
            throwsException);
        final union = Guard(null).asNumber().elseGetWrapper();
        expect(union.isGuardable(), false);
        expect(union.unwrap, throwsException);
      });
    });
