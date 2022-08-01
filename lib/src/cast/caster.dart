import 'package:cast_data/src/option/else.dart';
import 'package:cast_data/src/typedef/lazy_load.dart';

class PrimitiveCaster<T> {
  final Else<T> _elseOption;

  PrimitiveCaster._(this._elseOption);
  PrimitiveCaster(final dynamic t) : this._(Else(() => t as T, () => t is T));

  Else<T> cast() => _elseOption;
}

class DataStructureCaster<T> {
  final Else<T> _elseOption;

  DataStructureCaster._(this._elseOption);
  DataStructureCaster(final ParameterlessLazyLoad<T> t,
      final ParameterlessLazyLoad<bool> isMatchingType)
      : this._(Else(t, isMatchingType));

  Else<T> cast() => _elseOption;
}
