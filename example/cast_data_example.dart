import 'dart:convert';

import 'package:cast_data/cast_data.dart';

class Example {
  final String s;

  Example(this.s);

  factory Example.fromJson({required final String s}) => Example(s);

  Map<String, String> toJson() => <String, String>{
        's': s,
      };
}

void main() {
  // boolean caster, all return `else` methods
  // are applicable to string, num, double and int caster
  final booleanCaster = Cast(true).asBoolean();
  print(booleanCaster.elseGetNull());
  print(booleanCaster.elseGet(false));
  print(booleanCaster.elseLazyGet(() => false));
  print(booleanCaster.elseThrow('damn son'));
  final booleanWrapper = booleanCaster.elseGetWrapper();
  print(!booleanWrapper.isCastable() ? '' : booleanWrapper.unwrap());

  // the only caster for a data structure
  final listCaster =
      Cast(json.decode(json.encode([Example('0'), Example('1'), Example('2')])))
          .asListWithCustomPredicate<Example>(
    predicate: ((dynamic element) => element['s'] is String),
    map: (dynamic element) => Example.fromJson(
        s: Cast(element['s']).asString().elseThrow('expect s to be a string')),
  );
  print(listCaster.elseGet(List<Example>.empty()));
  print(listCaster.elseGetNull());
  print(listCaster.elseGet(List<Example>.empty()));
  print(listCaster.elseThrow('damn son'));
  final listWrapper = listCaster.elseGetWrapper();
  print(!listWrapper.isCastable() ? '' : listWrapper.unwrap());
}
