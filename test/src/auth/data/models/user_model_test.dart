import 'dart:convert';

import 'package:dashboard_bloc_tdd/core/utils/typdefs.dart';
import 'package:dashboard_bloc_tdd/src/auth/data/models/user_model.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tLocalUserModel = LocalUserModel.empty();

  test(
    'should be a sublclass of [LocalUser] entity',
    () => expect(tLocalUserModel, isA<LocalUser>()),
  );

  final tMap = jsonDecode(fixture('user.json')) as DataMap;
  group('fromMap', () {
    test('should return a valid [LocalUserModel] from the map', () {
      // act
      final result = LocalUserModel.fromMap(tMap);

      // assert
      expect(result, isA<LocalUserModel>());
      expect(result, equals(tLocalUserModel));
    });

    test(
      'should throw an [Error] when the map is invalid',
      () {
        final map = DataMap.from(tMap)..remove('uid');

        const call = LocalUserModel.fromMap;

        expect(() => call(map), throwsA(isA<Error>()));
      },
    );
  });

  group('toMap', () {
    test('should return a valid [DataMap] from the LocalUserModel', () {
      final result = tLocalUserModel.toMap();

      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test('should return valid [LocalUserModel] with updated valuse', () {
      final result = tLocalUserModel.copyWith(uid: '2');

      expect(result.uid, '2');
    });
  });
}
