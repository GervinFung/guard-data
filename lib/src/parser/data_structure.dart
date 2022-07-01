import 'package:parse_data/src/parser/parser.dart';
import 'package:parse_data/src/typedef/lazy_load.dart';

class ListParser<T> extends DataStructureParser<List<T>> {
  ListParser(final ParameterlessLazyLoad<List<T>> t,
      final ParameterlessLazyLoad<bool> isList)
      : super(t, isList);
}
