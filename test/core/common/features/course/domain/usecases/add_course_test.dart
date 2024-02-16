import 'package:dartz/dartz.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/domain/entities/course.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/domain/repos/course_repo.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/domain/usecases/add_course.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'course_repo.mock.dart';

void main() {
  late CoursRepo repo;
  late AddCourse usecase;
  final tCourse = Course.empty();

  setUp(() {
    repo = MockCourseRepo();
    usecase = AddCourse(repo);
    registerFallbackValue(tCourse);
  });

  test('should add course from the repo', () async {
    when(() => repo.addCourse(any()))
        .thenAnswer((_) async => const Right(null));

    await usecase.call(tCourse);

    verify(() => repo.addCourse(tCourse)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
