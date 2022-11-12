import 'package:guard_data/src/guard/guarder.dart';
import 'package:guard_data/src/typedef/lazy_load.dart';

class ListGuarder<T> extends DataStructureGuarder<List<T>> {
  ListGuarder(final ParameterlessLazyLoad<List<T>> t,
      final ParameterlessLazyLoad<bool> isList)
      : super(t, isList);
}
