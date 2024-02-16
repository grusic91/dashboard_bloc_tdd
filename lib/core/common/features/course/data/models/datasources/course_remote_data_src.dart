import 'package:dashboard_bloc_tdd/core/common/features/course/data/models/course_model.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/domain/entities/course.dart';

abstract class CourseRemotDataSrc {
  const CourseRemotDataSrc();

  Future<List<CourseModel>> getCourses();

  Future<void> addCourse(Course course);
}
