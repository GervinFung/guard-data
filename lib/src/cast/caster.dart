import 'package:guard_data/src/option/else.dart';
import 'package:guard_data/src/typedef/lazy_load.dart';

class PrimitiveGuarder<T> {
  final Else<T> _elseOption;

  PrimitiveGuarder._(this._elseOption);
  PrimitiveGuarder(final dynamic t) : this._(Else(() => t as T, () => t is T));

  Else<T> guard() => _elseOption;
}

class DataStructureGuarder<T> {
  final Else<T> _elseOption;

  DataStructureGuarder._(this._elseOption);
  DataStructureGuarder(final ParameterlessLazyLoad<T> t,
      final ParameterlessLazyLoad<bool> isMatchingType)
      : this._(Else(t, isMatchingType));

  Else<T> guard() => _elseOption;
}
