import 'package:guard_data/src/guard/guarder.dart';

class BooleanGuarder extends PrimitiveGuarder<bool> {
  BooleanGuarder(super.t);
}

class StringGuarder extends PrimitiveGuarder<String> {
  StringGuarder(super.t);
}

class IntGuarder extends PrimitiveGuarder<int> {
  IntGuarder(super.t);
}

class DoubleGuarder extends PrimitiveGuarder<double> {
  DoubleGuarder(super.t);
}

class NumberGuarder extends PrimitiveGuarder<num> {
  NumberGuarder(super.t);
}
