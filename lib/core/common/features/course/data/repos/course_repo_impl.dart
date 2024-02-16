import 'package:dartz/dartz.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/data/models/datasources/course_remote_data_src.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/domain/entities/course.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/domain/repos/course_repo.dart';
import 'package:dashboard_bloc_tdd/core/errors/exceptions.dart';
import 'package:dashboard_bloc_tdd/core/errors/failures.dart';
import 'package:dashboard_bloc_tdd/core/utils/typdefs.dart';

class CouresRepoImpl implements CoursRepo {
  const CouresRepoImpl(this._remoteDataSrc);

  final CourseRemotDataSrc _remoteDataSrc;

  @override
  ResultFuture<void> addCourse(Course course) async {
    try {
      await _remoteDataSrc.addCourse(course);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Course>> getCourses() async {
    try {
      final result = await _remoteDataSrc.getCourses();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
