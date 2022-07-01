import 'dart:convert';

import 'package:parse_data/parse_data.dart';

class Example {
  late final String s;

  Example(this.s);

  factory Example.fromJson({required final String s}) => Example(s);

  Map<String, String> toJson() => <String, String>{
        's': s,
      };
}

void main() {
  // boolean parser, all return `else` methods
  // are applicable to string, num, double and int parser
  late final booleanParser = Parse(true).asBoolean();
  print(booleanParser.elseGetNull());
  print(booleanParser.elseGet(false));
  print(booleanParser.elseLazyGet(() => false));
  print(booleanParser.elseThrow('damn son'));
  late final booleanWrapper = booleanParser.elseGetWrapper();
  print(!booleanWrapper.isParseable() ? '' : booleanWrapper.unwrap());

  // the only parser for a data structure
  late final listParser = Parse(
          json.decode(json.encode([Example('0'), Example('1'), Example('2')])))
      .asListWithCustomPredicate<Example>(
    predicate: ((dynamic element) => element['s'] is String),
    map: (dynamic element) => Example.fromJson(
        s: Parse(element['s']).asString().elseThrow('expect s to be a string')),
  );
  print(listParser.elseGet(List<Example>.empty()));
  print(listParser.elseGetNull());
  print(listParser.elseGet(List<Example>.empty()));
  print(listParser.elseThrow('damn son'));
  late final listWrapper = listParser.elseGetWrapper();
  print(!listWrapper.isParseable() ? '' : listWrapper.unwrap());
}
