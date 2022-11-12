import 'package:guard_data/guard_data.dart';
import 'package:test/test.dart';

void testBooleanGuarder() => group('Boolean Guarder', () {
      test('should guard value as boolean when value is boolean', () {
        expect(Guard(true).asBoolean().elseGetNull(), true);
        expect(Guard(false).asBoolean().elseGet(true), false);
        expect(Guard(false).asBoolean().elseLazyGet(() => true), false);
        expect(Guard(true).asBoolean().elseThrow('joke'), true);
        final union = Guard(false).asBoolean().elseGetWrapper();
        expect(union.isGuardable(), true);
        expect(union.unwrap(), false);
      });
      test('''
          should fail to guard value as boolean
          when value is not boolean 
          and take subsequent action,
          ''', () {
        expect(Guard(1).asBoolean().elseGetNull(), null);
        expect(Guard('string').asBoolean().elseGet(true), true);
        expect(Guard(List<bool>.empty()).asBoolean().elseLazyGet(() => false),
            false);
        expect(
            () => Guard(List<bool>.empty())
                .asBoolean()
                .elseThrow('array aint boolean'),
            throwsException);
        final union = Guard('adios').asBoolean().elseGetWrapper();
        expect(union.isGuardable(), false);
        expect(union.unwrap, throwsException);
      });
    });
