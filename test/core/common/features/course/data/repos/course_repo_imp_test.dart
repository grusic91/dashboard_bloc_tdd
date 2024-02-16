import 'package:dartz/dartz.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/data/models/course_model.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/data/models/datasources/course_remote_data_src.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/data/repos/course_repo_impl.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/domain/entities/course.dart';
import 'package:dashboard_bloc_tdd/core/errors/exceptions.dart';
import 'package:dashboard_bloc_tdd/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCourseRemoteDataSrc extends Mock implements CourseRemotDataSrc {}

void main() {
  late CourseRemotDataSrc remotDataSrc;
  late CouresRepoImpl repoImpl;

  final tCourse = CourseModel.empty();

  setUp(() {
    remotDataSrc = MockCourseRemoteDataSrc();
    repoImpl = CouresRepoImpl(remotDataSrc);
    registerFallbackValue(tCourse);
  });

  const tException = ServerException(
    message: 'Something went wrong',
    statusCode: '505',
  );

  group('addCourse', () {
    test(
        'should complete successfully when call to remote data '
        'source is successfull', () async {
      when(() => remotDataSrc.addCourse(any()))
          .thenAnswer((_) async => Future.value);

      final reuslt = await repoImpl.addCourse(tCourse);
      expect(reuslt, const Right<dynamic, void>(null));
      verify(() => remotDataSrc.addCourse(tCourse)).called(1);
      verifyNoMoreInteractions(remotDataSrc);
    });

    test('should fail when call to remote data source', () async {
      when(() => remotDataSrc.addCourse(any())).thenThrow(tException);

      final reuslt = await repoImpl.addCourse(tCourse);
      expect(
        reuslt,
        Left<Failure, void>(
          ServerFailure.fromException(tException),
        ),
      );
      verify(() => remotDataSrc.addCourse(tCourse)).called(1);
      verifyNoMoreInteractions(remotDataSrc);
    });
  });

  group('getCourses', () {
    test(
        'should complete successfully when call to '
        'getCourses to remote data source', () async {
      when(() => remotDataSrc.getCourses()).thenAnswer((_) async => [tCourse]);
      final result = await repoImpl.getCourses();
      expect(result, isA<Right<dynamic, List<Course>>>());
      verify(() => remotDataSrc.getCourses()).called(1);
      verifyNoMoreInteractions(remotDataSrc);
    });

    test(
        'should fail when call to '
        'getCourses to remote data source', () async {
      when(() => remotDataSrc.getCourses()).thenThrow(tException);
      final result = await repoImpl.getCourses();
      expect(
        result,
        Left<Failure, dynamic>(
          ServerFailure.fromException(tException),
        ),
      );
      verify(() => remotDataSrc.getCourses()).called(1);
      verifyNoMoreInteractions(remotDataSrc);
    });
  });
}
