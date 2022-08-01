import 'package:cast_data/cast_data.dart';
import 'package:test/test.dart';

void testIntCaster() => group('Int Caster', () {
      test('should cast value as integer when value is integer', () {
        expect(Cast(1000).asInt().elseGetNull(), 1000);
        expect(Cast(2).asInt().elseGet(1), 2);
        expect(Cast(20000).asInt().elseLazyGet(() => 1), 20000);
        expect(Cast(0).asInt().elseThrow('joke'), 0);
        final union = Cast(3).asInt().elseGetWrapper();
        expect(union.isCastable(), true);
        expect(union.unwrap(), 3);
      });
      test('''
          should fail to cast value as integer
          when value is not integer 
          and take subsequent action
          ''', () {
        expect(Cast(false).asInt().elseGetNull(), null);
        expect(Cast('string').asInt().elseGet(1), 1);
        expect(Cast(1.0).asInt().elseLazyGet(() => 90 * 90), 8100);
        expect(
            () =>
                Cast(List<dynamic>.empty()).asInt().elseThrow('array aint int'),
            throwsException);
        final union = Cast(null).asInt().elseGetWrapper();
        expect(union.isCastable(), false);
        expect(union.unwrap, throwsException);
      });
    });
