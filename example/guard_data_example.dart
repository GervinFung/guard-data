import 'dart:convert';

import 'package:guard_data/guard_data.dart';

class Example {
  final String s;

  Example(this.s);

  factory Example.fromJson({required final String s}) => Example(s);

  Map<String, String> toJson() => <String, String>{
        's': s,
      };
}

void main() {
  // boolean guarder, all return `else` methods
  // are applicable to string, num, double and int guarder
  final booleanGuarder = Guard(true).asBoolean();
  print(booleanGuarder.elseGetNull());
  print(booleanGuarder.elseGet(false));
  print(booleanGuarder.elseLazyGet(() => false));
  print(booleanGuarder.elseThrow('damn son'));
  final booleanWrapper = booleanGuarder.elseGetWrapper();
  print(!booleanWrapper.isGuardable() ? '' : booleanWrapper.unwrap());

  // the only guarder for a data structure
  final listGuarder =
      Guard(json.decode(json.encode([Example('0'), Example('1'), Example('2')])))
          .asListWithCustomPredicate<Example>(
    predicate: ((dynamic element) => element['s'] is String),
    map: (dynamic element) => Example.fromJson(
        s: Guard(element['s']).asString().elseThrow('expect s to be a string')),
  );
  print(listGuarder.elseGet(List<Example>.empty()));
  print(listGuarder.elseGetNull());
  print(listGuarder.elseGet(List<Example>.empty()));
  print(listGuarder.elseThrow('damn son'));
  final listWrapper = listGuarder.elseGetWrapper();
  print(!listWrapper.isGuardable() ? '' : listWrapper.unwrap());
}
