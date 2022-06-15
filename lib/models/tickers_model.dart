import 'dart:convert';

class TickersModel {
  String e;
  int E;
  String s; // symbol
  String p;
  String P;
  String w;
  String x;
  String c;
  String Q;
  String b; // bid price
  String B;
  String a; // ask prce
  String A;
  String o; // open
  String h; // high
  String l; // low
  String v; // volume
  String q;
  int O;
  int C;
  int F;
  int L;
  int n;

  TickersModel({
    required this.e,
    required this.E,
    required this.s,
    required this.p,
    required this.P,
    required this.w,
    required this.x,
    required this.c,
    required this.Q,
    required this.b,
    required this.B,
    required this.a,
    required this.A,
    required this.o,
    required this.h,
    required this.l,
    required this.v,
    required this.q,
    required this.O,
    required this.C,
    required this.F,
    required this.L,
    required this.n,
  });

  TickersModel copyWith({
    String? e,
    int? E,
    String? s,
    String? p,
    String? P,
    String? w,
    String? x,
    String? c,
    String? Q,
    String? b,
    String? B,
    String? a,
    String? A,
    String? o,
    String? h,
    String? l,
    String? v,
    String? q,
    int? O,
    int? C,
    int? F,
    int? L,
    int? n,
  }) {
    return TickersModel(
      e: e ?? this.e,
      E: E ?? this.E,
      s: s ?? this.s,
      p: p ?? this.p,
      P: P ?? this.P,
      w: w ?? this.w,
      x: x ?? this.x,
      c: c ?? this.c,
      Q: Q ?? this.Q,
      b: b ?? this.b,
      B: B ?? this.B,
      a: a ?? this.a,
      A: A ?? this.A,
      o: o ?? this.o,
      h: h ?? this.h,
      l: l ?? this.l,
      v: v ?? this.v,
      q: q ?? this.q,
      O: O ?? this.O,
      C: C ?? this.C,
      F: F ?? this.F,
      L: L ?? this.L,
      n: n ?? this.n,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'e': e,
      'E': E,
      's': s,
      'p': p,
      'P': P,
      'w': w,
      'x': x,
      'c': c,
      'Q': Q,
      'b': b,
      'B': B,
      'a': a,
      'A': A,
      'o': o,
      'h': h,
      'l': l,
      'v': v,
      'q': q,
      'O': O,
      'C': C,
      'F': F,
      'L': L,
      'n': n,
    };
  }

  factory TickersModel.fromMap(Map<String, dynamic> map) {
    return TickersModel(
      e: map['e'] ?? '',
      E: map['E']?.toInt() ?? 0,
      s: map['s'] ?? '',
      p: map['p'] ?? '',
      P: map['P'] ?? '',
      w: map['w'] ?? '',
      x: map['x'] ?? '',
      c: map['c'] ?? '',
      Q: map['Q'] ?? '',
      b: map['b'] ?? '',
      B: map['B'] ?? '',
      a: map['a'] ?? '',
      A: map['A'] ?? '',
      o: map['o'] ?? '',
      h: map['h'] ?? '',
      l: map['l'] ?? '',
      v: map['v'] ?? '',
      q: map['q'] ?? '',
      O: map['O']?.toInt() ?? 0,
      C: map['C']?.toInt() ?? 0,
      F: map['F']?.toInt() ?? 0,
      L: map['L']?.toInt() ?? 0,
      n: map['n']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TickersModel.fromJson(String source) =>
      TickersModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TickersModel(e: $e, E: $E, s: $s, p: $p, P: $P, w: $w, x: $x, c: $c, Q: $Q, b: $b, B: $B, a: $a, A: $A, o: $o, h: $h, l: $l, v: $v, q: $q, O: $O, C: $C, F: $F, L: $L, n: $n)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TickersModel &&
        other.e == e &&
        other.E == E &&
        other.s == s &&
        other.p == p &&
        other.P == P &&
        other.w == w &&
        other.x == x &&
        other.c == c &&
        other.Q == Q &&
        other.b == b &&
        other.B == B &&
        other.a == a &&
        other.A == A &&
        other.o == o &&
        other.h == h &&
        other.l == l &&
        other.v == v &&
        other.q == q &&
        other.O == O &&
        other.C == C &&
        other.F == F &&
        other.L == L &&
        other.n == n;
  }

  @override
  int get hashCode {
    return e.hashCode ^
        E.hashCode ^
        s.hashCode ^
        p.hashCode ^
        P.hashCode ^
        w.hashCode ^
        x.hashCode ^
        c.hashCode ^
        Q.hashCode ^
        b.hashCode ^
        B.hashCode ^
        a.hashCode ^
        A.hashCode ^
        o.hashCode ^
        h.hashCode ^
        l.hashCode ^
        v.hashCode ^
        q.hashCode ^
        O.hashCode ^
        C.hashCode ^
        F.hashCode ^
        L.hashCode ^
        n.hashCode;
  }
}
