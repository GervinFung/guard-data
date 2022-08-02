import 'package:cast_data/src/exception/cast.dart';
import 'package:cast_data/src/typedef/lazy_load.dart';

class Wrapper<T> {
  final bool _isCastable;
  final ParameterlessLazyLoad<T> _t;

  Wrapper(this._isCastable, this._t);

  bool isCastable() => _isCastable;

  T unwrap() => !_isCastable ? throw CastException('''
          cannot unwrap as $_t cannot be casted as $T, you should call `isCastable` method before unwrapping
          ''') : _t();
}

class Else<T> {
  final ParameterlessLazyLoad<T> _t;
  final ParameterlessLazyLoad<bool> _isMatchingType;

  Else(this._t, this._isMatchingType);

  Wrapper<T> elseGetWrapper() => Wrapper(_isMatchingType(), _t);

  T? elseGetNull() => _isMatchingType() ? _t() : null;

  T elseLazyGet<A extends T>(final ParameterlessLazyLoad<A> a) =>
      _isMatchingType() ? _t() : a();

  T elseGet<A extends T>(final A a) => _isMatchingType() ? _t() : a;

  T elseThrow(final String message) =>
      _isMatchingType() ? _t() : throw CastException(message);
}
