import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:driver/models/driver.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../failure.dart';

import 'package:rxdart/rxdart.dart';

import 'get.base.url.dart';

String host = Platform.isAndroid ? '10.0.2.2' : 'localhost';

class AuthService {
  final String _baseApiUrl = getBaseApiUrl();
  final Dio _dio = Dio();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();
  User get user => _firebaseAuth.currentUser!;

  Stream<Driver> get driver {
    return _firebaseAuth.authStateChanges().switchMap((user) {
      if (user != null) {
        return FirebaseFirestore.instance
            .doc('drivers/${user.uid}')
            .snapshots()
            .map<Driver>((snapshot) => Driver.fromMap(snapshot.data()));
      } else {
        return const Stream.empty();
      }
    });
  }

  Future<Response> createCode(String phone) async {
    try {
      Response response = await _dio
          .post("$_baseApiUrl/driver/create-code", data: {'phone': phone});
      return response;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw Failure("check_your_internet_connection");
      }
      if (e.error is TimeoutException) throw Failure("time_out");
    }
    throw Failure("unexpected_error");
  }

  Future<Response> verifyCode(String phone, String code) async {
    try {
      Response response = await _dio.post("$_baseApiUrl/driver/verify-code",
          data: {'phone': phone, 'code': code});
      return response;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw Failure("check_your_internet_connection");
      }
      if (e.error is TimeoutException) throw Failure("time_out");
    }
    throw Failure("unexpected_error");
  }

  Future<void> sigout() async {
    await FirebaseAuth.instance.signOut();
  }
}
