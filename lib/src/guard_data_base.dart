import 'package:guard_data/src/guard/data_structure.dart';
import 'package:guard_data/src/guard/primitive.dart';
import 'package:guard_data/src/option/else.dart';

typedef DynamicList = List<dynamic>;
typedef DynamicMap = Map<dynamic, dynamic>;

class Guard {
  final dynamic _t;
  Guard(this._t);

  Else<bool> asBoolean() => BooleanGuarder(_t).guard();
  Else<double> asDouble() => DoubleGuarder(_t).guard();
  Else<int> asInt() => IntGuarder(_t).guard();
  Else<List<T>> asList<T>(final T Function(dynamic e) map) => ListGuarder<T>(
      () => (_t as List<dynamic>).map(map).toList(),
      () =>
          _t is DynamicList &&
          (_t as DynamicList).every((dynamic e) => e is T)).guard();
  Else<List<T>> asListWithCustomPredicate<T>(
          {required final T Function(dynamic e) map,
          required final bool Function(dynamic) predicate}) =>
      ListGuarder<T>(() => (_t as List<dynamic>).map(map).toList(),
              () => _t is DynamicList && (_t as DynamicList).every(predicate))
          .guard();

  Else<num> asNumber() => NumberGuarder(_t).guard();

  Else<String> asString() => StringGuarder(_t).guard();
}
