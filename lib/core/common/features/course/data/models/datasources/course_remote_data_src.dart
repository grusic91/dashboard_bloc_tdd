import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/data/models/course_model.dart';
import 'package:dashboard_bloc_tdd/core/common/features/course/domain/entities/course.dart';
import 'package:dashboard_bloc_tdd/core/errors/exceptions.dart';
import 'package:dashboard_bloc_tdd/src/chat/data/models/group_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class CourseRemotDataSrc {
  const CourseRemotDataSrc();

  Future<List<CourseModel>> getCourses();

  Future<void> addCourse(Course course);
}

class CourseRemoteDataSrcImpl implements CourseRemotDataSrc {
  const CourseRemoteDataSrcImpl({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _storage = storage,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  @override
  Future<void> addCourse(Course course) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      final courseRef = _firestore.collection('courses').doc();

      final groupRef = _firestore.collection('groups').doc();

      var courseModel = (course as CourseModel)
          .copyWith(id: courseRef.id, groupId: groupRef.id);

      if (courseModel.imageIsFile) {
        final imageRef = _storage.ref().child(
            'courses/${courseModel.id}/profile_image/${courseModel.title}--pfp');
        await imageRef.putFile(File(courseModel.image!)).then((value) async {
          final url = await value.ref.getDownloadURL();
          courseModel = courseModel.copyWith(image: url);
        });
      }

      await courseRef.set(courseModel.toMap());

      final group = GroupModel(
        id: groupRef.id,
        name: course.title,
        members: const [],
        courseId: courseRef.id,
        groupImageUrl: courseModel.image,
      );

      return groupRef.set(group.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occured',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<List<CourseModel>> getCourses() {
    // TODO: implement getCourses
    throw UnimplementedError();
  }
}
