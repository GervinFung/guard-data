import 'package:cast_data/src/cast/data_structure.dart';
import 'package:cast_data/src/cast/primitive.dart';
import 'package:cast_data/src/option/else.dart';

typedef DynamicList = List<dynamic>;
typedef DynamicMap = Map<dynamic, dynamic>;

class Cast {
  final dynamic _t;
  Cast(this._t);

  Else<bool> asBoolean() => BooleanCaster(_t).cast();
  Else<double> asDouble() => DoubleCaster(_t).cast();
  Else<int> asInt() => IntCaster(_t).cast();
  Else<List<T>> asList<T>(final T Function(dynamic e) map) => ListCaster<T>(
      () => (_t as List<dynamic>).map(map).toList(),
      () =>
          _t is DynamicList &&
          (_t as DynamicList).every((dynamic e) => e is T)).cast();
  Else<List<T>> asListWithCustomPredicate<T>(
          {required final T Function(dynamic e) map,
          required final bool Function(dynamic) predicate}) =>
      ListCaster<T>(() => (_t as List<dynamic>).map(map).toList(),
              () => _t is DynamicList && (_t as DynamicList).every(predicate))
          .cast();

  Else<num> asNumber() => NumberCaster(_t).cast();

  Else<String> asString() => StringCaster(_t).cast();
}
