import 'package:parse_data/parse_data.dart';
import 'package:test/test.dart';

void testBooleanParser() => group('Boolean Parser', () {
      test('should parse value as boolean when value is boolean', () {
        expect(Parse(true).asBoolean().elseGetNull(), true);
        expect(Parse(false).asBoolean().elseGet(true), false);
        expect(Parse(false).asBoolean().elseLazyGet(() => true), false);
        expect(Parse(true).asBoolean().elseThrow('joke'), true);
        late final union = Parse(false).asBoolean().elseGetWrapper();
        expect(union.isParseable(), true);
        expect(union.unwrap(), false);
      });
      test('''
          should fail to parse value as boolean
          when value is not boolean 
          and take subsequent action,
          ''', () {
        expect(Parse(1).asBoolean().elseGetNull(), null);
        expect(Parse('string').asBoolean().elseGet(true), true);
        expect(Parse(List<bool>.empty()).asBoolean().elseLazyGet(() => false),
            false);
        expect(
            () => Parse(List<bool>.empty())
                .asBoolean()
                .elseThrow('array aint boolean'),
            throwsException);
        late final union = Parse('adios').asBoolean().elseGetWrapper();
        expect(union.isParseable(), false);
        expect(union.unwrap, throwsException);
      });
    });
