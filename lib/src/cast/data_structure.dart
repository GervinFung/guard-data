import 'package:cast_data/src/cast/caster.dart';
import 'package:cast_data/src/typedef/lazy_load.dart';

class ListCaster<T> extends DataStructureCaster<List<T>> {
  ListCaster(final ParameterlessLazyLoad<List<T>> t,
      final ParameterlessLazyLoad<bool> isList)
      : super(t, isList);
}
