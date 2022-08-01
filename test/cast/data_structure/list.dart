import 'dart:convert';

import 'package:cast_data/cast_data.dart';
import 'package:test/test.dart';

import '../test_class.dart';

void testListCaster() => group('List Caster', () {
      test('should cast value as generic list when value is list', () {
        expect(
            Cast(json.decode(json.encode([1, 2, 3])))
                .asListWithCustomPredicate<int>(
                    map: (dynamic element) => element as int,
                    predicate: (dynamic element) => element is int)
                .elseLazyGet(List<int>.empty),
            [1, 2, 3]);
        expect(
            Cast([1.0, 2.0, 3.0])
                .asList<double>((dynamic element) => element as double)
                .elseGetNull(),
            [1.0, 2.0, 3.0]);
        expect(
            Cast([1, 2.2, 3.0])
                .asListWithCustomPredicate<num>(
                    map: (dynamic element) => element as num,
                    predicate: (dynamic element) => element is num)
                .elseThrow('should work'),
            [1, 2.2, 3.0]);
        expect(
            Cast(json.decode(json.encode([Temp(''), Temp('1'), Temp('2')])))
                .asListWithCustomPredicate<Temp>(
                  predicate: ((dynamic element) => element['s'] is String),
                  map: (dynamic element) => Temp.fromJson(
                      s: Cast(element['s'])
                          .asString()
                          .elseThrow('expect s to be a string')),
                )
                .elseGet(List<Temp>.empty()),
            [Temp(''), Temp('1'), Temp('2')]);
        final union = Cast([1, 2, 3])
            .asList<int>(((dynamic element) => element as int))
            .elseGetWrapper();
        expect(union.isCastable(), true);
        expect(union.unwrap(), [1, 2, 3]);
      });
      test('''
          should fail to cast value as generic list
          when value is not list 
          and take subsequent action
          ''', () {
        expect(
            Cast('string')
                .asListWithCustomPredicate<String>(
                    map: (dynamic element) => element as String,
                    predicate: (dynamic element) => element is String)
                .elseLazyGet(List<String>.empty),
            List<String>.empty());
        expect(
            Cast(true)
                .asListWithCustomPredicate<bool>(
                    map: (dynamic element) => element as bool,
                    predicate: (dynamic element) => element is bool)
                .elseGetNull(),
            null);
        expect(
            Cast(1)
                .asListWithCustomPredicate<int>(
                    map: (dynamic element) => element as int,
                    predicate: (dynamic element) => element is int)
                .elseGet(List<int>.empty()),
            List<int>.empty());
        expect(
            () => Cast(123)
                .asListWithCustomPredicate<int>(
                    map: (dynamic element) => element as int,
                    predicate: (dynamic element) => element is int)
                .elseThrow('number aint list'),
            throwsException);
        final union = Cast(null).asBoolean().elseGetWrapper();
        expect(union.isCastable(), false);
        expect(union.unwrap, throwsException);
      });
    });
