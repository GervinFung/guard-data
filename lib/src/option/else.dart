import 'package:parse_data/src/exception/parser.dart';
import 'package:parse_data/src/typedef/lazy_load.dart';

class Wrapper<T> {
  final bool _isParseable;
  final ParameterlessLazyLoad<T> _t;

  Wrapper(this._isParseable, this._t);

  bool isParseable() => _isParseable;

  T unwrap() => !_isParseable ? throw ParserException('''
          cannot unwrap as $_t cannot be parsed as $T, you should call `isParseable` method before unwrapping
          ''') : _t();
}

class Else<T> {
  final ParameterlessLazyLoad<T> _t;
  final ParameterlessLazyLoad<bool> _isMatchingType;

  Else(this._t, this._isMatchingType);

  Wrapper<T> elseGetWrapper() => Wrapper(_isMatchingType(), _t);

  T? elseGetNull() => _isMatchingType() ? _t() : null;

  T elseLazyGet<A extends T>(final ParameterlessLazyLoad<A> a) => elseGet(a());

  T elseGet<A extends T>(final A a) => _isMatchingType() ? _t() : a;

  T elseThrow(final String message) =>
      _isMatchingType() ? _t() : throw ParserException(message);
}
