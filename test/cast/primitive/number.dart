import 'package:cast_data/cast_data.dart';
import 'package:test/test.dart';

void testNumberCaster() => group('Number Caster', () {
      test('should cast value as number when value is number', () {
        expect(Cast(1.12).asNumber().elseGetNull(), 1.12);
        expect(Cast(2.2).asNumber().elseGet(1), 2.2);
        expect(Cast(20000).asNumber().elseLazyGet(() => 100), 20000);
        expect(Cast(1000).asNumber().elseThrow('joke'), 1000);
        final union = Cast(3.241).asNumber().elseGetWrapper();
        expect(union.isCastable(), true);
        expect(union.unwrap(), 3.241);
      });
      test('''
          should fail to cast value as number
          when value is not number 
          and take subsequent action
          ''', () {
        expect(Cast(true).asNumber().elseGetNull(), null);
        expect(Cast('string').asNumber().elseGet(1), 1);
        expect(Cast(List<int>.empty()).asNumber().elseLazyGet(() => 1 + 1), 2);
        expect(
            () => Cast(List<int>.empty())
                .asNumber()
                .elseThrow('array aint number'),
            throwsException);
        final union = Cast(null).asNumber().elseGetWrapper();
        expect(union.isCastable(), false);
        expect(union.unwrap, throwsException);
      });
    });
