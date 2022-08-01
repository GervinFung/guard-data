import 'package:cast_data/cast_data.dart';
import 'package:test/test.dart';

void testDoubleCaster() => group('Double Caster', () {
      test('should cast value as double when value is double', () {
        expect(Cast(1.12).asDouble().elseGetNull(), 1.12);
        expect(Cast(2.2).asDouble().elseGet(2.222), 2.2);
        expect(Cast(20000.22).asDouble().elseLazyGet(() => 3.3), 20000.22);
        expect(Cast(1000.99999999).asDouble().elseThrow('joke'), 1000.99999999);
        final union = Cast(3.142).asDouble().elseGetWrapper();
        expect(union.isCastable(), true);
        expect(union.unwrap(), 3.142);
      });
      test('''
          should fail to cast value as double
          when value is not double 
          and take subsequent action
          ''', () {
        expect(Cast(true).asDouble().elseGetNull(), null);
        expect(Cast('string').asDouble().elseGet(2.22222), 2.22222);
        expect(Cast(1).asDouble().elseLazyGet(() => 1.0 + 1), 2);
        expect(
            () => Cast(List<int>.empty())
                .asDouble()
                .elseThrow('array aint double'),
            throwsException);
        final union = Cast(null).asDouble().elseGetWrapper();
        expect(union.isCastable(), false);
        expect(union.unwrap, throwsException);
      });
    });
