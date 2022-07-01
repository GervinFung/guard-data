import 'dart:convert';

import 'package:parse_data/parse_data.dart';
import 'package:test/test.dart';

import '../test_class.dart';

void testListParser() => group('List Parser', () {
      test('should parse value as generic list when value is list', () {
        expect(
            Parse(json.decode(json.encode([1, 2, 3])))
                .asListWithCustomPredicate<int>(
                    map: (dynamic element) => element as int,
                    predicate: (dynamic element) => element is int)
                .elseLazyGet(List<int>.empty),
            [1, 2, 3]);
        expect(
            Parse([1.0, 2.0, 3.0])
                .asList<double>((dynamic element) => element as double)
                .elseGetNull(),
            [1.0, 2.0, 3.0]);
        expect(
            Parse([1, 2.2, 3.0])
                .asListWithCustomPredicate<num>(
                    map: (dynamic element) => element as num,
                    predicate: (dynamic element) => element is num)
                .elseThrow('should work'),
            [1, 2.2, 3.0]);
        expect(
            Parse(json.decode(json.encode([Temp(''), Temp('1'), Temp('2')])))
                .asListWithCustomPredicate<Temp>(
                  predicate: ((dynamic element) => element['s'] is String),
                  map: (dynamic element) => Temp.fromJson(
                      s: Parse(element['s'])
                          .asString()
                          .elseThrow('expect s to be a string')),
                )
                .elseGet(List<Temp>.empty()),
            [Temp(''), Temp('1'), Temp('2')]);
        final union = Parse([1, 2, 3])
            .asList<int>(((dynamic element) => element as int))
            .elseGetWrapper();
        expect(union.isParseable(), true);
        expect(union.unwrap(), [1, 2, 3]);
      });
      test('''
          should fail to parse value as generic list
          when value is not list 
          and take subsequent action
          ''', () {
        expect(
            Parse('string')
                .asListWithCustomPredicate<String>(
                    map: (dynamic element) => element as String,
                    predicate: (dynamic element) => element is String)
                .elseLazyGet(List<String>.empty),
            List<String>.empty());
        expect(
            Parse(true)
                .asListWithCustomPredicate<bool>(
                    map: (dynamic element) => element as bool,
                    predicate: (dynamic element) => element is bool)
                .elseGetNull(),
            null);
        expect(
            Parse(1)
                .asListWithCustomPredicate<int>(
                    map: (dynamic element) => element as int,
                    predicate: (dynamic element) => element is int)
                .elseGet(List<int>.empty()),
            List<int>.empty());
        expect(
            () => Parse(123)
                .asListWithCustomPredicate<int>(
                    map: (dynamic element) => element as int,
                    predicate: (dynamic element) => element is int)
                .elseThrow('number aint list'),
            throwsException);
        final union = Parse(null).asBoolean().elseGetWrapper();
        expect(union.isParseable(), false);
        expect(union.unwrap, throwsException);
      });
    });
