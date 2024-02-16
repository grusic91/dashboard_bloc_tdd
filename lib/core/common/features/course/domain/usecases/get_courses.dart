import 'package:dashboard_bloc_tdd/core/common/features/course/domain/entities/course.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/domain/repos/course_repo.dart';
import 'package:dashboard_bloc_tdd/core/usecases/usecases.dart';
import 'package:dashboard_bloc_tdd/core/utils/typdefs.dart';

class GetCourses extends UsecaseWithoutParams<List<Course>> {
  GetCourses(this._repo);

  final CoursRepo _repo;

  @override
  ResultFuture<List<Course>> call() async => _repo.getCourses();
}
