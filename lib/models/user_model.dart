// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class UserModel {
  String name;
  String username;
  String email;
  String password;
  num net_commission;
  num amount;
  num equity;
  num free_margin;
  num margin;
  num commission;
  bool isDisabled;
  bool isPhoneVerified;
  String uid;
  String phone;

  UserModel({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.net_commission,
    required this.amount,
    required this.equity,
    required this.free_margin,
    required this.margin,
    required this.commission,
    required this.isDisabled,
    required this.isPhoneVerified,
    required this.uid,
    required this.phone,
  });

  UserModel copyWith({
    String? name,
    String? username,
    String? email,
    String? password,
    num? net_commission,
    num? amount,
    num? equity,
    num? free_margin,
    num? margin,
    num? commission,
    bool? isDisabled,
    bool? isPhoneVerified,
    String? uid,
    String? phone,
  }) {
    return UserModel(
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      net_commission: net_commission ?? this.net_commission,
      amount: amount ?? this.amount,
      equity: equity ?? this.equity,
      free_margin: free_margin ?? this.free_margin,
      margin: margin ?? this.margin,
      commission: commission ?? this.commission,
      isDisabled: isDisabled ?? this.isDisabled,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'net_commission': net_commission,
      'amount': amount,
      'equity': equity,
      'free_margin': free_margin,
      'margin': margin,
      'commission': commission,
      'isDisabled': isDisabled,
      'isPhoneVerified': isPhoneVerified,
      'uid': uid,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      net_commission: map['net_commission'] ?? 0,
      amount: map['amount'] ?? 0,
      equity: map['equity'] ?? 0,
      free_margin: map['free_margin'] ?? 0,
      margin: map['margin'] ?? 0,
      commission: map['commission'] ?? 0,
      isDisabled: map['isDisabled'] ?? false,
      isPhoneVerified: map['isPhoneVerified'] ?? false,
      uid: map['uid'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, username: $username, email: $email, password: $password, net_commission: $net_commission, amount: $amount, equity: $equity, free_margin: $free_margin, margin: $margin, commission: $commission, isDisabled: $isDisabled, isPhoneVerified: $isPhoneVerified, uid: $uid, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.username == username &&
        other.email == email &&
        other.password == password &&
        other.net_commission == net_commission &&
        other.amount == amount &&
        other.equity == equity &&
        other.free_margin == free_margin &&
        other.margin == margin &&
        other.commission == commission &&
        other.isDisabled == isDisabled &&
        other.isPhoneVerified == isPhoneVerified &&
        other.uid == uid &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        username.hashCode ^
        email.hashCode ^
        password.hashCode ^
        net_commission.hashCode ^
        amount.hashCode ^
        equity.hashCode ^
        free_margin.hashCode ^
        margin.hashCode ^
        commission.hashCode ^
        isDisabled.hashCode ^
        isPhoneVerified.hashCode ^
        uid.hashCode ^
        phone.hashCode;
  }
}
