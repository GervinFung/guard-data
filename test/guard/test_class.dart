class Temp {
  final String s;

  Temp(this.s);

  factory Temp.fromJson({required final String s}) => Temp(s);

  Map<String, String> toJson() => <String, String>{
        's': s,
      };

  @override
  bool operator ==(Object other) {
    return other is Temp && other.s == s;
  }

  @override
  int get hashCode => s.hashCode;
}
