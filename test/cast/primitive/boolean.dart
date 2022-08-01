import 'package:cast_data/cast_data.dart';
import 'package:test/test.dart';

void testBooleanCaster() => group('Boolean Caster', () {
      test('should cast value as boolean when value is boolean', () {
        expect(Cast(true).asBoolean().elseGetNull(), true);
        expect(Cast(false).asBoolean().elseGet(true), false);
        expect(Cast(false).asBoolean().elseLazyGet(() => true), false);
        expect(Cast(true).asBoolean().elseThrow('joke'), true);
        final union = Cast(false).asBoolean().elseGetWrapper();
        expect(union.isCastable(), true);
        expect(union.unwrap(), false);
      });
      test('''
          should fail to cast value as boolean
          when value is not boolean 
          and take subsequent action,
          ''', () {
        expect(Cast(1).asBoolean().elseGetNull(), null);
        expect(Cast('string').asBoolean().elseGet(true), true);
        expect(Cast(List<bool>.empty()).asBoolean().elseLazyGet(() => false),
            false);
        expect(
            () => Cast(List<bool>.empty())
                .asBoolean()
                .elseThrow('array aint boolean'),
            throwsException);
        final union = Cast('adios').asBoolean().elseGetWrapper();
        expect(union.isCastable(), false);
        expect(union.unwrap, throwsException);
      });
    });
