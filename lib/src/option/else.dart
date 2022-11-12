import 'package:guard_data/src/exception/guard.dart';
import 'package:guard_data/src/typedef/lazy_load.dart';

class Wrapper<T> {
  final bool _isGuardable;
  final ParameterlessLazyLoad<T> _t;

  Wrapper(this._isGuardable, this._t);

  bool isGuardable() => _isGuardable;

  T unwrap() => !_isGuardable ? throw GuardException('''
          cannot unwrap as $_t cannot be guarded as $T, you should call `isGuardable` method before unwrapping
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
      _isMatchingType() ? _t() : throw GuardException(message);
}
