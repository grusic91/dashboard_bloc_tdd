import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/data/models/course_model.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/domain/entities/course.dart';
import 'package:dashboard_bloc_tdd/core/utils/typdefs.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../fixtures/fixture_reader.dart';

void main() {
  final timeStampData = {'_seconds': 1677483548, '_nanoseconds': 123456000};
  final date =
      DateTime.fromMicrosecondsSinceEpoch(timeStampData['_seconds']!).add(
    Duration(microseconds: timeStampData['_nanoseconds']!),
  );

  final timeStamp = Timestamp.fromDate(date);
  final tCourseModel = CourseModel.empty();

  final tMap = jsonDecode(fixture('course.json')) as DataMap;
  tMap['createdAt'] = timeStamp;
  tMap['updatedAt'] = timeStamp;

  test('should be subclass of [Course] entity', () {
    expect(tCourseModel, isA<Course>());
  });

  group('empty', () {
    test('should return a [CourseModel] with emty data', () {
      final result = CourseModel.empty();
      expect(result.title, '_empty.title');
    });
  });

  group('fromMap', () {
    test('should return a [CourseModel] with the correct data', () async {
      final result = CourseModel.fromMap(tMap);

      expect(result, equals(tCourseModel));
    });
  });
  group('toMap', () {
    test('should return a [CourseModel] with the correct data', () async {
      final result = tCourseModel.toMap()
        ..remove('createdAt')
        ..remove('updatedAt');

      final map = DataMap.from(tMap)
        ..remove('createdAt')
        ..remove('updatedAt');

      expect(result, equals(map));
    });
  });

  group('copyWith', () {
    test('should return a [CourseModel] with the new data', () async {
      final result = tCourseModel.copyWith(title: 'New Title');

      expect(result.title, 'New Title');
    });
  });
}
