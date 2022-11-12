import 'package:guard_data/guard_data.dart';
import 'package:test/test.dart';

void testDoubleGuarder() => group('Double Guarder', () {
      test('should guard value as double when value is double', () {
        expect(Guard(1.12).asDouble().elseGetNull(), 1.12);
        expect(Guard(2.2).asDouble().elseGet(2.222), 2.2);
        expect(Guard(20000.22).asDouble().elseLazyGet(() => 3.3), 20000.22);
        expect(Guard(1000.99999999).asDouble().elseThrow('joke'), 1000.99999999);
        final union = Guard(3.142).asDouble().elseGetWrapper();
        expect(union.isGuardable(), true);
        expect(union.unwrap(), 3.142);
      });
      test('''
          should fail to guard value as double
          when value is not double 
          and take subsequent action
          ''', () {
        expect(Guard(true).asDouble().elseGetNull(), null);
        expect(Guard('string').asDouble().elseGet(2.22222), 2.22222);
        expect(Guard(1).asDouble().elseLazyGet(() => 1.0 + 1), 2);
        expect(
            () => Guard(List<int>.empty())
                .asDouble()
                .elseThrow('array aint double'),
            throwsException);
        final union = Guard(null).asDouble().elseGetWrapper();
        expect(union.isGuardable(), false);
        expect(union.unwrap, throwsException);
      });
    });
