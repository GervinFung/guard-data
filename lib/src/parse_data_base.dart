import 'package:parse_data/src/option/else.dart';
import 'package:parse_data/src/parser/data_structure.dart';
import 'package:parse_data/src/parser/non_data_structure.dart';

typedef DynamicList = List<dynamic>;
typedef DynamicMap = Map<dynamic, dynamic>;

class Parse {
  late final dynamic _t;
  Parse(this._t);

  Else<bool> asBoolean() => BooleanParser(_t).parse();
  Else<String> asString() => StringParser(_t).parse();
  Else<int> asInt() => IntParser(_t).parse();
  Else<double> asDouble() => DoubleParser(_t).parse();
  Else<num> asNumber() => NumberParser(_t).parse();

  Else<List<T>> asList<T>(final T Function(dynamic e) map) => ListParser<T>(
      () => (_t as List<dynamic>).map(map).toList(),
      () =>
          _t is DynamicList &&
          (_t as DynamicList).every((dynamic e) => e is T)).parse();

  Else<List<T>> asListWithCustomPredicate<T>(
          {required final T Function(dynamic e) map,
          required final bool Function(dynamic) predicate}) =>
      ListParser<T>(() => (_t as List<dynamic>).map(map).toList(),
              () => _t is DynamicList && (_t as DynamicList).every(predicate))
          .parse();
}
