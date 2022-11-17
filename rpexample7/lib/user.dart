// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart ' as http;
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class User {
  final String name;
  final String email;

  const User({
    required this.name,
    required this.email,
  });

  User copyWith({
    String? name,
    String? email,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(name: $name, email: $email)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name && other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode;
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier(super.state);

// option 2
  // UserNotifier():super( const User(
  //     name: 'name',
  //     age: 0,
  //   ){
  //     run time constracture
  //  nameUpdate('hello')
  // },);

  void nameUpdate(String n) {
    //option 1
    // state = User(name: n, age: state.age);

    // option 2
    state = state.copyWith(name: n);
  }
}

class FeatchUserData {
  Future<User> fatch() {
    const url = 'https://jsonplaceholder.typicode.com/users/5';
    return http.get(Uri.parse(url)).then((value) => User.fromJson(value.body));
  }
}
