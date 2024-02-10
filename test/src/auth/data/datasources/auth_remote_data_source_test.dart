import 'package:dashboard_bloc_tdd/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential([User? user]) : _user = user;

  User? _user;

  @override
  User? get user => _user;

  set user(User? value) {
    if (_user != value) _user = value;
  }
}

main() {
  late MockFirebaseAuth authClient;
  late FakeFirebaseFirestore cloudStoreClient;
  late MockFirebaseStorage dbClient;
  late AuthRemoteDataSource dataSource;
  late UserCredential userCredential;
  late MockUser mockUser;

  setUpAll(() async {
    authClient = MockFirebaseAuth();
    cloudStoreClient = FakeFirebaseFirestore();
    dbClient = MockFirebaseStorage();
    mockUser = MockUser();
    userCredential = MockUserCredential(mockUser);

    dataSource = AuthRemoteataSourceImpl(
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,
      dbClient: dbClient,
    );
  });
}
