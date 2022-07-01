import 'package:parse_data/src/option/else.dart';
import 'package:parse_data/src/typedef/lazy_load.dart';

class NonDataStructureParser<T> {
  late final Else<T> _elseOption;

  NonDataStructureParser._(this._elseOption);
  NonDataStructureParser(final dynamic t)
      : this._(Else(() => t as T, () => t is T));

  Else<T> parse() => _elseOption;
}

class DataStructureParser<T> {
  late final Else<T> _elseOption;

  DataStructureParser._(this._elseOption);
  DataStructureParser(final ParameterlessLazyLoad<T> t,
      final ParameterlessLazyLoad<bool> isMatchingType)
      : this._(Else(t, isMatchingType));

  Else<T> parse() => _elseOption;
}
