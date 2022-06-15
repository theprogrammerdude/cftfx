import 'dart:convert';

class HistoricModel {
  num v;
  num vw;
  num o;
  num h;
  num l;
  num c;
  num n;
  int t;

  HistoricModel({
    required this.v,
    required this.vw,
    required this.o,
    required this.h,
    required this.l,
    required this.c,
    required this.n,
    required this.t,
  });

  HistoricModel copyWith({
    num? v,
    num? vw,
    num? o,
    num? h,
    num? l,
    num? c,
    num? n,
    int? t,
  }) {
    return HistoricModel(
      v: v ?? this.v,
      vw: vw ?? this.vw,
      o: o ?? this.o,
      h: h ?? this.h,
      l: l ?? this.l,
      c: c ?? this.c,
      n: n ?? this.n,
      t: t ?? this.t,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'v': v,
      'vw': vw,
      'o': o,
      'h': h,
      'l': l,
      'c': c,
      'n': n,
      't': t,
    };
  }

  factory HistoricModel.fromMap(Map<String, dynamic> map) {
    return HistoricModel(
      v: map['v'] ?? 0,
      vw: map['vw'] ?? 0,
      o: map['o'] ?? 0,
      h: map['h'] ?? 0,
      l: map['l'] ?? 0,
      c: map['c'] ?? 0,
      n: map['n'] ?? 0,
      t: map['t']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoricModel.fromJson(String source) =>
      HistoricModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HistoricModel(v: $v, vw: $vw, o: $o, h: $h, l: $l, c: $c, n: $n, t: $t)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoricModel &&
        other.v == v &&
        other.vw == vw &&
        other.o == o &&
        other.h == h &&
        other.l == l &&
        other.c == c &&
        other.n == n &&
        other.t == t;
  }

  @override
  int get hashCode {
    return v.hashCode ^
        vw.hashCode ^
        o.hashCode ^
        h.hashCode ^
        l.hashCode ^
        c.hashCode ^
        n.hashCode ^
        t.hashCode;
  }
}
